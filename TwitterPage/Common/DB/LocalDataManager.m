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
    
    dispatch_async(saveDBQueue, ^{
        [dbQueue inDatabase:^(FMDatabase *db){
            [self createTablesIfNotExist:db];
        }];
    });
    
    return self;
}

-(void)createTablesIfNotExist:(FMDatabase*)database {
    if (![database open]) {
        NSLog(@"database cant be opened");
        return;
    }
    
    BOOL tablesExist = YES;
    FMResultSet *existingSettingsSet = [database executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' AND name='Settings'"];
    //если искали таблицу по имени и результат не пустой, значит она точно существует и наоборот
    if (![existingSettingsSet next]) tablesExist = NO;
    FMResultSet *existingTweetsSet = [database executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' AND name='Tweets'"];
    if (![existingTweetsSet next]) tablesExist = NO;
    FMResultSet *existingUsersSet = [database executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' AND name='Users'"];
    if (![existingUsersSet next]) tablesExist = NO;
    
    if (!tablesExist)
    {
        [database executeUpdate:@"CREATE TABLE Settings (id integer primary key, showAvatars integer)"];
        [database executeUpdate:@"INSERT INTO Settings (id, showAvatars) VALUES (1, 1);"];
        
        [database executeUpdate:@"CREATE TABLE Tweets (id integer primary key autoincrement, showAvatars integer)"];
        [database executeUpdate:@"CREATE TABLE Users (userid text primary key, name text, screenname text, avatarurl text, creationdate integer)"];
    }
    
    [database close];
}

-(SettingsModel*)getSettings {
    SettingsModel *settings = [[SettingsModel alloc] init];
    [dbQueue inDatabase:^(FMDatabase *database){
        if (![database open]) {
            NSLog(@"database cant be opened");
            return;
        }
        
        FMResultSet *s = [database executeQuery:@"SELECT * FROM Settings"];
        while ([s next])//next вызывать всегда - если сразу вернёт NO, значит ничего не нашёл
        {
            long showAvatars = [s longForColumn:@"showAvatars"];
            
            settings.isAvatarsHidden = !showAvatars;
        }
        
        [database close];
    }];
    
    return settings;
}
-(void)setSettings:(SettingsModel *)newSettings {
    
    dispatch_async(saveDBQueue, ^{
        [dbQueue inDatabase:^(FMDatabase *database){
            if (![database open]) {
                NSLog(@"database cant be opened");
                return;
            }
            
            [database executeUpdate:[NSString stringWithFormat:@"REPLACE INTO Settings (id, showAvatars) VALUES (1, %d);", !newSettings.isAvatarsHidden]];
            
            [database close];
        }];
    });
}

/*
- (void)makeRequestsWithDatabase:(FMDatabase*)database
{
    if (![database open])
    {
        database = nil;
        NSLog(@"database cant be opened");
    }
    
    BOOL tableExist = NO;
    FMResultSet *existingSet = [database executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' AND name='userTable'"];
    if ([existingSet next])
    {
        tableExist = YES;//если искали таблицу по имени и результат не пустой, значит она точно существует
    }
    
    if (tableExist)
    {
        FMResultSet *s = [database executeQuery:@"SELECT * FROM userTable"];
        while ([s next])//next вызывать всегда - если сразу вернёт NO, значит ничего не нашёл
        {
            NSString* name = [s stringForColumn:@"name"];
            long number = [s longForColumn:@"number"];
            
            NSLog(@"name %@, number %ld", name, number);
        }
    }
    else
    {
        BOOL createDbResult = [database executeUpdate:@"CREATE TABLE userTable (id integer primary key autoincrement, name text, number integer)"];
        if (createDbResult)
        {
            BOOL insertResult = [database executeUpdate:@"INSERT INTO userTable (name, number) VALUES ('name1', 10);"];
            NSLog(@"insertResult %ld", (long)insertResult);
        }
    }
    
    [database close];
}
*/
@end
