//
//  SettingsViewModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsViewModel.h"

@implementation SettingsViewModel

-(instancetype)initWithShowAvatars:(BOOL)showAvatars {
    self = [super init];
    if (self) {
        _showAvatars = showAvatars;
    }
    return self;
}

@end
