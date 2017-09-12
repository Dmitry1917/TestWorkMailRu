//
//  UserViewModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "UserViewModel.h"

@implementation UserViewModel

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
