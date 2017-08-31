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
    //получить настройки
    showAvatars = [[SettingsManager shared] needShowAvatarsInTimeline];
    
    [_presenter updateModel:nil];
    
    [self updateTimeline];
}

-(void)updateTimeline {
    [TwitterRequestsManager askTimelineWithCompletionHandler:^(NSArray <TweetModel*> *tweets){
        if (tweets.count > 0) {
            
            currentTweets = tweets;
            //сохранить загруженное
            
            
            //отправить на показ
            [self.presenter updateModel:[self prepareViewModels]];
        }
        else {
            
        }
        
        [self setupCounterTimer];
    }];
}

-(NSArray <TweetViewModel*>*)prepareViewModels {
    NSMutableArray <TweetViewModel*>* tweetViewModels = [NSMutableArray array];
    for (TweetModel *tweet in currentTweets) {
        TweetViewModel *tweetVM = [[TweetViewModel alloc] init];
        tweetVM.text = tweet.text;
        tweetVM.formattedDate = [CommonDateFormatter formattedTweetDate:tweet.date];
        tweetVM.favorited = tweet.favorited;
        tweetVM.showAvatar = showAvatars;
        
        UserViewModel *userVM = [[UserViewModel alloc] init];
        userVM.name = tweet.user.name;
        userVM.screenName = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
        userVM.avatarUrlStr = tweet.user.avatarUrlStr;
        
        tweetVM.user = userVM;
        [tweetViewModels addObject:tweetVM];
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
    [self.presenter updateModel:[self prepareViewModels]];
}

@end
