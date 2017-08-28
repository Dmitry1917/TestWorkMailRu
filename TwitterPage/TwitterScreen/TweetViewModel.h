//
//  TweetViewModel.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserViewModel.h"

@interface TweetViewModel : NSObject

@property NSString *text;
@property NSString *formattedDate;
@property UserViewModel *user;

@end
