//
//  LocalDataManager.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "LocalDataManager.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

#import "SettingsModel.h"
#import "TweetModel.h"

@implementation LocalDataManager {
    FMDatabaseQueue *dbQueue;
    dispatch_queue_t saveDBQueue;
}

+(instancetype)shared {
    static LocalDataManager *_sharedInstance;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LocalDataManager alloc] init];
    });
    return _sharedInstance;
}

-(instancetype)init {
    self = [super init];
    
    NSString *pathToDocs = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject].absoluteString;
    NSString *pathToDB = [pathToDocs stringByAppendingPathComponent:@"database"];
    dbQueue = [FMDatabaseQueue databaseQueueWithPath:pathToDB];
    saveDBQueue = dispatch_queue_create("saveDBQueue", DISPATCH_QUEUE_SERIAL);
    [self createTablesIfNotExist];
    return self;
}

-(void)executeBlockForDatabase:(void (^)(FMDatabase *database))blockForDB {
    if (!blockForDB) return;
    [dbQueue inDatabase:^(FMDatabase *database){
        if (![database open]) {
            NSLog(@"database cant be opened");
            return;
        }
        blockForDB(database);
        [database close];
    }];
}

-(void)createTablesIfNotExist {//обходимся без отдельной queue тут, так как иначе есть шанс начать запросы до того, как созданы таблицы
    [self executeBlockForDatabase:^(FMDatabase *database){
        BOOL tablesExist = YES;
        FMResultSet *existingSettingsSet = [database executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' AND name='Settings'"];
        //если искали таблицу по имени и результат не пустой, значит она точно существует и наоборот
        if (![existingSettingsSet next]) tablesExist = NO;
        FMResultSet *existingTweetsSet = [database executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' AND name='Tweets'"];
        if (![existingTweetsSet next]) tablesExist = NO;
        FMResultSet *existingUsersSet = [database executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' AND name='Users'"];
        if (![existingUsersSet next]) tablesExist = NO;
        
        if (!tablesExist) {
            [database executeUpdate:@"CREATE TABLE Settings (id integer primary key, showAvatars integer)"];
            [database executeUpdate:@"INSERT INTO Settings (id, showAvatars) VALUES (1, 1);"];
            
            [database executeUpdate:@"CREATE TABLE Tweets (tweetid text primary key, tweettext text, date integer, favorited integer, userid text)"];
            [database executeUpdate:@"CREATE TABLE Users (userid text primary key, name text, screenname text, avatarurl text, creationdate integer)"];
        }
    }];
}

-(SettingsModel*)getSettings {
    SettingsModel *settings = [[SettingsModel alloc] init];
    [self executeBlockForDatabase:^(FMDatabase *database){
        FMResultSet *s = [database executeQuery:@"SELECT * FROM Settings"];
        while ([s next])//next вызывать всегда - если сразу вернёт NO, значит ничего не нашёл
        {
            long showAvatars = [s longForColumn:@"showAvatars"];
            settings.isAvatarsHidden = (showAvatars == 0);
        }
    }];
    return settings;
}
-(void)setSettings:(SettingsModel *)newSettings {
    dispatch_async(saveDBQueue, ^{
        [self executeBlockForDatabase:^(FMDatabase *database){
            [database executeUpdate:[NSString stringWithFormat:@"REPLACE INTO Settings (id, showAvatars) VALUES (1, %d);", !newSettings.isAvatarsHidden]];
        }];
    });
}

#pragma mark работу с запросами можно оптимизировать
-(NSArray<TweetModel*>*)getSavedTweets {
    NSMutableArray <TweetModel*> *tweets = [NSMutableArray array];
    [self executeBlockForDatabase:^(FMDatabase *database){
        FMResultSet *setTweets = [database executeQuery:@"SELECT * FROM Tweets"];
        while ([setTweets next])
        {
            TweetModel *tweet = [[TweetModel alloc] init];
            tweet.tweetID = [setTweets stringForColumn:@"tweetid"];
            tweet.text = [setTweets stringForColumn:@"tweettext"];
            tweet.date = [NSDate dateWithTimeIntervalSince1970:[setTweets longForColumn:@"date"]];
            tweet.favorited = ([setTweets longForColumn:@"favorited"] != 0);
            
            NSString *userID = [setTweets stringForColumn:@"userid"];
            
            UserModel *user = [[UserModel alloc] init];
            
            if (userID) {
                FMResultSet *setUsers = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM Users WHERE userid=%@", userID]];
                while ([setUsers next]) {//userid - primary key, поэтому результат один
                    user.userID = userID;
                    user.name = [setUsers stringForColumn:@"name"];
                    user.screenName = [setUsers stringForColumn:@"screenname"];
                    user.avatarUrlStr = [setUsers stringForColumn:@"avatarurl"];
                    user.creationDate = [NSDate dateWithTimeIntervalSince1970:[setUsers longForColumn:@"creationdate"]];
                }
            }
            tweet.user = user;
            [tweets addObject:tweet];
        }
    }];
    
    return tweets;
}
-(void)addOrReplaceTweets:(NSArray<TweetModel *> *)newTweets {
    dispatch_async(saveDBQueue, ^{
        [self executeBlockForDatabase:^(FMDatabase *database){
            for (TweetModel *tweet in newTweets) {
                [database executeUpdate:[NSString stringWithFormat:@"REPLACE INTO Tweets (tweetid, tweettext, date, favorited, userid) VALUES ('%@', '%@', %ld, %ld, '%@');", tweet.tweetID, tweet.text, (long)tweet.date.timeIntervalSince1970, (long)tweet.favorited, tweet.user.userID]];
                [database executeUpdate:[NSString stringWithFormat:@"REPLACE INTO Users (userid, name, screenname, avatarurl, creationdate) VALUES ('%@', '%@', '%@', '%@', %ld);", tweet.user.userID, tweet.user.name, tweet.user.screenName, tweet.user.avatarUrlStr, (long)tweet.user.creationDate.timeIntervalSince1970]];
            }
        }];
    });
}

@end
