//
//  SettingsManager.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SETTINGS_CHANGED_NOTIFICATION @"SETTINGS_CHANGED_NOTIFICATION"

@interface SettingsManager : NSObject

+(instancetype)shared;

-(BOOL)needShowAvatarsInTimeline;
-(void)setNeedShowAvatarsInTimeline:(BOOL)needShow;

@end
