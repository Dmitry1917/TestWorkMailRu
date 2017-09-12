//
//  SettingsPONSOModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 10.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsPONSOModel.h"

@implementation SettingsPONSOModel

-(instancetype)initWithShowAvatars:(BOOL)showAvatars {
    self = [super init];
    if (self) {
        _showAvatars = showAvatars;
    }
    return self;
}

@end
