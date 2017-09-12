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
    [self.view updateModel:settingsVM];
}

@end
