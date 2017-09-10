//
//  TwitterScreenPresenter.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterScreenPresenter.h"
#import "CommonDateFormatter.h"
#import "TweetPONSOModel.h"
#import "TweetViewModel.h"

@implementation TwitterScreenPresenter

-(void)updateModel:(NSArray <TweetPONSOModel*> *)tweets {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.view) return;
        [self.view updateModel:[self prepareViewModelsFromPONSO:tweets]];
    });
}

-(void)updateCounter:(int)number {
    NSString *counterText = @"";
    if (number > 0) counterText = [NSString stringWithFormat:@"%d", number];
    [self.view updateCounter:counterText];
}

-(NSArray <TweetViewModel*>*)prepareViewModelsFromPONSO:(NSArray <TweetPONSOModel*> *)tweetsPONSO {
    NSMutableArray <TweetViewModel*>* tweetViewModels = [NSMutableArray array];
    for (TweetPONSOModel *tweet in tweetsPONSO) {
        TweetViewModel *tweetVM = [[TweetViewModel alloc] init];
        tweetVM.text = tweet.text;
        tweetVM.formattedDate = [CommonDateFormatter formattedTweetDate:tweet.date];
        tweetVM.favorited = tweet.favorited;
        tweetVM.showAvatar = tweet.showAvatar;
        
        UserViewModel *userVM = [[UserViewModel alloc] init];
        userVM.name = tweet.user.name;
        userVM.screenName = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
        userVM.avatarUrlStr = tweet.user.avatarUrlStr;
        
        tweetVM.user = userVM;
        [tweetViewModels addObject:tweetVM];
    }
    return tweetViewModels;
}

@end
