//
//  SettingsScreenInteractor.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsScreenInteractor.h"
#import "SettingsManager.h"
#import "SettingsPONSOModel.h"

@implementation SettingsScreenInteractor

-(void)viewDidLoad {
    SettingsPONSOModel *settingsPM = [[SettingsPONSOModel alloc] initWithShowAvatars:[[SettingsManager shared] needShowAvatarsInTimeline]];
    [self.presenter updateModel:settingsPM];
}

-(void)setAvatarsHidden:(BOOL)isHidden {
    [[SettingsManager shared] setNeedShowAvatarsInTimeline:!isHidden];
}

@end
