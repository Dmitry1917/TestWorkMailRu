//
//  SettingsScreenPresenter.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsScreenPresenter.h"

@implementation SettingsScreenPresenter

-(void)updateModel:(SettingsViewModel *)settings {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view updateModel:settings];
    });
}

@end
