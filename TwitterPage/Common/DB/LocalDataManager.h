//
//  LocalDataManager.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SettingsModel;

@interface LocalDataManager : NSObject

+(instancetype)shared;
-(SettingsModel*)getSettings;
-(void)setSettings:(SettingsModel*)newSettings;

@end
