//
//  UserPONSOModel.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 10.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPONSOModel : NSObject

@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSString *screenName;
@property(nonatomic, readonly) NSString *avatarUrlStr;

-(instancetype)initWithName:(NSString*)name screenName:(NSString*)screenName avatarUrlStr:(NSString*)avatarUrlStr;

@end
