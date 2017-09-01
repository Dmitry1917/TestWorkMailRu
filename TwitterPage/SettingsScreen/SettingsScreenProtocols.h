//
//  SettingsScreenProtocols.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#ifndef SettingsScreenProtocols_h
#define SettingsScreenProtocols_h
#import "SettingsViewModel.h"

@protocol SettingsScreenVIPView <NSObject>

-(void)updateModel:(SettingsViewModel *)settings;

@end

@protocol SettingsScreenVIPInteractor <NSObject>

-(void)viewDidLoad;
-(void)setAvatarsHidden:(BOOL)isHidden;

@end

@protocol SettingsScreenVIPPresenter <NSObject>

-(void)updateModel:(SettingsViewModel*)settings;

@end

#endif /* SettingsScreenProtocols_h */
