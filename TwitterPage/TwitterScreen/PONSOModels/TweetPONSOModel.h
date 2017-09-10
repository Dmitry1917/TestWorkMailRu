//
//  TweetPONSOModel.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 10.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserPONSOModel.h"

@interface TweetPONSOModel : NSObject

@property NSString *text;
@property NSDate *date;
@property BOOL favorited;
@property BOOL showAvatar;
@property UserPONSOModel *user;

@end
