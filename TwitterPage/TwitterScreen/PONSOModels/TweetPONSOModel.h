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

@property(nonatomic, readonly) NSString *text;
@property(nonatomic, readonly) NSDate *date;
@property(nonatomic, readonly) BOOL favorited;
@property(nonatomic, readonly) BOOL showAvatar;
@property(nonatomic, readonly) UserPONSOModel *user;

-(instancetype)initWithText:(NSString*)text date:(NSDate*)date favorited:(BOOL)favorited showAvatar:(BOOL)showAvatar user:(UserPONSOModel*)user;

@end
