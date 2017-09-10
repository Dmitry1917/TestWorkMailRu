//
//  TweetPONSOModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 10.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TweetPONSOModel.h"

@implementation TweetPONSOModel

-(instancetype)initWithText:(NSString *)text date:(NSDate *)date favorited:(BOOL)favorited showAvatar:(BOOL)showAvatar user:(UserPONSOModel *)user {
    self = [super init];
    if (self) {
        _text = text;
        _date = date;
        _favorited = favorited;
        _showAvatar = showAvatar;
        _user = user;
    }
    return self;
}

@end
