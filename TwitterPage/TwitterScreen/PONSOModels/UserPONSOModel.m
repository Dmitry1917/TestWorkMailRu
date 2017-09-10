//
//  UserPONSOModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 10.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "UserPONSOModel.h"

@implementation UserPONSOModel

-(instancetype)initWithName:(NSString *)name screenName:(NSString *)screenName avatarUrlStr:(NSString *)avatarUrlStr {
    self = [super init];
    if (self) {
        _name = name;
        _screenName = screenName;
        _avatarUrlStr = avatarUrlStr;
    }
    return self;
}

@end
