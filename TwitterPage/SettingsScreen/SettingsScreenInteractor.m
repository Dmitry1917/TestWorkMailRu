//
//  SettingsScreenInteractor.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsScreenInteractor.h"
#import "SettingsManager.h"

@implementation SettingsScreenInteractor

-(void)viewDidLoad {
    SettingsViewModel *settingsVM = [[SettingsViewModel alloc] init];
    settingsVM.showAvatars = [[SettingsManager shared] needShowAvatarsInTimeline];
    [self.presenter updateModel:settingsVM];
}

-(void)setAvatarHidden:(BOOL)isHidden {
    [[SettingsManager shared] setNeedShowAvatarsInTimeline:!isHidden];
}

@end
