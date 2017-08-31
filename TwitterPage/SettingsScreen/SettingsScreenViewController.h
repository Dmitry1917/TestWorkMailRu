//
//  SettingsScreenViewController.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsScreenProtocols.h"

@interface SettingsScreenViewController : UIViewController <SettingsScreenVIPView>

@property(nonatomic, strong) NSObject <SettingsScreenVIPInteractor> *interactor;

@end
