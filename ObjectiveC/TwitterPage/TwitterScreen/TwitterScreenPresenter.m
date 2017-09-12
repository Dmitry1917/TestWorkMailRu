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
    if (!self.view) return;
    [self.view updateModel:[self prepareViewModelsFromPONSO:tweets]];
}

-(void)updateCounter:(int)number {
    NSString *counterText = @"";
    if (number > 0) counterText = [NSString stringWithFormat:@"%d", number];
    [self.view updateCounter:counterText];
}

-(NSArray <TweetViewModel*>*)prepareViewModelsFromPONSO:(NSArray <TweetPONSOModel*> *)tweetsPONSO {
    NSMutableArray <TweetViewModel*>* tweetViewModels = [NSMutableArray array];
    for (TweetPONSOModel *tweet in tweetsPONSO) {
        UserViewModel *userVM = [[UserViewModel alloc] initWithName:tweet.user.name screenName:[NSString stringWithFormat:@"@%@", tweet.user.screenName] avatarUrlStr:tweet.user.avatarUrlStr];
        TweetViewModel *tweetVM = [[TweetViewModel alloc] initWithText:tweet.text formattedDate:[CommonDateFormatter formattedTweetDate:tweet.date] favorited:tweet.favorited showAvatar:tweet.showAvatar user:userVM];
        [tweetViewModels addObject:tweetVM];
    }
    return tweetViewModels;
}

@end
