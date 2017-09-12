//
//  SettingsViewModel.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsViewModel : NSObject

@property(nonatomic, readonly) BOOL showAvatars;

-(instancetype)initWithShowAvatars:(BOOL)showAvatars;

@end
