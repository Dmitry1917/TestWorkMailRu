//
//  TwitterScreenPresenter.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterScreenPresenter.h"
#import "CommonDateFormatter.h"

@implementation TwitterScreenPresenter

-(void)updateModel {
    TweetViewModel *tweet1 = [[TweetViewModel alloc] init];
    tweet1.text = @"tweet1 text";
    tweet1.formattedDate = [CommonDateFormatter formattedTweetDate:[NSDate date]];
    tweet1.user = [[UserViewModel alloc] init];
    tweet1.user.name = @"name1";
    tweet1.user.avatarUrlStr = @"https://cdn4.iconfinder.com/data/icons/country-flag-1/744/The_Peoples_Republic-128.png";
    
    TweetViewModel *tweet2 = [[TweetViewModel alloc] init];
    tweet2.text = @"tweet2 text\ntest\ntest\n\ntest again";
    tweet2.formattedDate = [CommonDateFormatter formattedTweetDate:[NSDate dateWithTimeIntervalSinceNow:-3600]];
    tweet2.user = [[UserViewModel alloc] init];
    tweet2.user.name = @"name2";
    tweet2.user.avatarUrlStr = @"https://cdn4.iconfinder.com/data/icons/country-flag-1/744/Israel-128.png";
    
    TweetViewModel *tweet3 = [[TweetViewModel alloc] init];
    tweet3.text = @"";
    tweet3.formattedDate = [CommonDateFormatter formattedTweetDate:[NSDate dateWithTimeIntervalSinceNow:-23600]];
    tweet3.user = [[UserViewModel alloc] init];
    tweet3.user.name = @"name3";
    tweet3.user.avatarUrlStr = @"";
    
    TweetViewModel *tweet4 = [[TweetViewModel alloc] init];
    tweet4.text = @"tweet4 text";
    tweet4.formattedDate = [CommonDateFormatter formattedTweetDate:[NSDate dateWithTimeIntervalSinceNow:-23600]];
    tweet4.user = [[UserViewModel alloc] init];
    tweet4.user.name = @"name4";
    tweet4.user.avatarUrlStr = @"https://cdn4.iconfinder.com/data/icons/country-flag-1/744/Australia-128.png";
    
    [_view updateModel:@[tweet1, tweet2, tweet3, tweet4]];
}

@end
