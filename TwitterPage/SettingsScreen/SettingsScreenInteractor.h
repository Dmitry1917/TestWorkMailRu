//
//  SettingsScreenInteractor.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsScreenProtocols.h"

@interface SettingsScreenInteractor : NSObject <SettingsScreenVIPInteractor>

@property(nonatomic, strong) NSObject <SettingsScreenVIPPresenter> *presenter;

@end
