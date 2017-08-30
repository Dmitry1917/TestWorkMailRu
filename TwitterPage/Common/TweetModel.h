//
//  TweetModel.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonModel.h"
#import "UserModel.h"

@interface TweetModel : CommonModel

@property NSString *tweetID;
@property NSString *text;
@property NSString *formattedDate;
@property UserModel *user;

@end
