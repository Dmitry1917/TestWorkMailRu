//
//  SettingsScreenPresenter.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsScreenPresenter.h"
#import "SettingsPONSOModel.h"
#import "SettingsViewModel.h"

@implementation SettingsScreenPresenter

-(void)updateModel:(SettingsPONSOModel *)settings {
    SettingsViewModel *settingsVM = [[SettingsViewModel alloc] initWithShowAvatars:settings.showAvatars];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view updateModel:settingsVM];
    });
}

@end
