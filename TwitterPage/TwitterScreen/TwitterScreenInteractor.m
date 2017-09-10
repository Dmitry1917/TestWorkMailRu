//
//  TwitterScreenInteractor.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterScreenInteractor.h"
#import "TwitterRequestsManager.h"
#import "CommonDateFormatter.h"
#import "SettingsManager.h"
#import "LocalDataManager.h"
#import "TweetModel.h"
#import "TweetPONSOModel.h"

@implementation TwitterScreenInteractor {
    NSTimer *refreshTimer;
    int refreshCounter;
    volatile BOOL showAvatars;
    
    NSArray <TweetModel*> *currentTweets;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsChanged) name:SETTINGS_CHANGED_NOTIFICATION object:nil];
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidLoad {
    showAvatars = [[SettingsManager shared] needShowAvatarsInTimeline];
    currentTweets = [[LocalDataManager shared] getSavedTweets];
    
    [_presenter updateModel:[self preparePONSOModels]];
    
    [self updateTimeline];
}

#pragma mark Можно не заменять, а пополнять список твитов загруженными, да и в целом усложнить логику работы, но для определения точного механизма требуется информация об экране и его функционале
-(void)updateTimeline {
    [TwitterRequestsManager askTimelineWithCompletionHandler:^(NSArray <TweetModel*> *tweets){
        if (tweets.count > 0) {
            
            currentTweets = tweets;
            //сохранить загруженное
            [[LocalDataManager shared] addOrReplaceTweets:tweets];
            
            //отправить на показ
            [self.presenter updateModel:[self preparePONSOModels]];
        }
        else {
            
        }
        
        [self setupCounterTimer];
    }];
}

-(NSArray <TweetPONSOModel*>*)preparePONSOModels {
    NSMutableArray <TweetPONSOModel*>* tweetViewModels = [NSMutableArray array];
    for (TweetModel *tweet in currentTweets) {
        UserPONSOModel *userPM = [[UserPONSOModel alloc] initWithName:tweet.user.name screenName:tweet.user.screenName avatarUrlStr:tweet.user.avatarUrlStr];
        TweetPONSOModel *tweetPM = [[TweetPONSOModel alloc] initWithText:tweet.text date:tweet.date favorited:tweet.favorited showAvatar:showAvatars user:userPM];
        [tweetViewModels addObject:tweetPM];
    }
    return tweetViewModels;
}

-(void)setupCounterTimer {
    dispatch_async(dispatch_get_main_queue(), ^{
        refreshCounter = 60;
        refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
    });
}

-(void)timerTick {
    refreshCounter--;
    if (refreshCounter == 0)
    {
        [refreshTimer invalidate];
        [self updateTimeline];
    }
    [self.presenter updateCounter:refreshCounter];
}

-(void)viewDidDismissedOrPoped {
    [refreshTimer invalidate];
}

-(void)settingsChanged {
    showAvatars = [[SettingsManager shared] needShowAvatarsInTimeline];
    [self.presenter updateModel:[self preparePONSOModels]];
}

@end
