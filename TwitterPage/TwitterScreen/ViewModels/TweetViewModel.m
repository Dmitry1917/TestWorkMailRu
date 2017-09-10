//
//  TweetViewModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TweetViewModel.h"

@implementation TweetViewModel

-(instancetype)initWithText:(NSString *)text formattedDate:(NSString *)formattedDate favorited:(BOOL)favorited showAvatar:(BOOL)showAvatar user:(UserViewModel *)user {
    self = [super init];
    if (self) {
        _text = text;
        _formattedDate = formattedDate;
        _favorited = favorited;
        _showAvatar = showAvatar;
        _user = user;
    }
    return self;
}

@end
