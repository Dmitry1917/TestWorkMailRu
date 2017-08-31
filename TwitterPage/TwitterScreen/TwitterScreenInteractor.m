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

@implementation TwitterScreenInteractor {
    NSTimer *refreshTimer;
    int refreshCounter;
}

-(void)viewDidLoad {
    [_presenter updateModel:nil];
    
    [self updateTimeline];
}

-(void)updateTimeline {
    [TwitterRequestsManager askTimelineWithCompletionHandler:^(NSArray <TweetModel*> *tweets){
        if (tweets.count > 0) {
            
            //сохранить загруженное
            
            
            //отправить на показ
            NSMutableArray <TweetViewModel*>* tweetViewModels = [NSMutableArray array];
            for (TweetModel *tweet in tweets) {
                TweetViewModel *tweetVM = [[TweetViewModel alloc] init];
                tweetVM.text = tweet.text;
                tweetVM.formattedDate = [CommonDateFormatter formattedTweetDate:tweet.date];
                tweetVM.favorited = tweet.favorited;
                
                UserViewModel *userVM = [[UserViewModel alloc] init];
                userVM.name = tweet.user.name;
                userVM.screenName = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
                userVM.avatarUrlStr = tweet.user.avatarUrlStr;
                
                tweetVM.user = userVM;
                [tweetViewModels addObject:tweetVM];
            }
            
            [_presenter updateModel:tweetViewModels];
        }
        else {
            
        }
        
        [self setupCounterTimer];
    }];
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

@end
