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

@property(nonatomic, readonly) NSString *text;
@property(nonatomic, readonly) NSString *formattedDate;
@property(nonatomic, readonly) BOOL favorited;
@property(nonatomic, readonly) BOOL showAvatar;
@property(nonatomic, readonly) UserViewModel *user;

-(instancetype)initWithText:(NSString*)text formattedDate:(NSString*)formattedDate favorited:(BOOL)favorited showAvatar:(BOOL)showAvatar user:(UserViewModel*)user;

@end
