//
//  SettingsPONSOModel.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 10.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsPONSOModel : NSObject

@property(nonatomic, readonly) BOOL showAvatars;

-(instancetype)initWithShowAvatars:(BOOL)showAvatars;

@end
