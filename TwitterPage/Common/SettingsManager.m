//
//  SettingsManager.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsManager.h"
#import "SettingsModel.h"

@implementation SettingsManager {
    SettingsModel *settings;
}

+(instancetype)shared {
    static SettingsManager *_sharedInstance;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SettingsManager alloc] init];
    });
    return _sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        //запросим из базы
        
        settings = [[SettingsModel alloc] init];
        settings.isAvatarsHidden = NO;
    }
    return self;
}

-(BOOL)needShowAvatarsInTimeline {
    return !settings.isAvatarsHidden;
}

-(void)setNeedShowAvatarsInTimeline:(BOOL)needShow {
    settings.isAvatarsHidden = !needShow;
    [[NSNotificationCenter defaultCenter] postNotificationName:SETTINGS_CHANGED_NOTIFICATION object:nil];
}

@end
