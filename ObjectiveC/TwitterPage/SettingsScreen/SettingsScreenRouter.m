//
//  SettingsScreenRouter.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsScreenRouter.h"
#import "SettingsScreenInteractor.h"
#import "SettingsScreenPresenter.h"
#import "SettingsScreenViewController.h"

@implementation SettingsScreenRouter

+(UIViewController*)createSettingsScreenModule {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SettingsScreenStoryboard" bundle:[NSBundle mainBundle]];
    SettingsScreenViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"SettingsScreenViewController"];
    SettingsScreenInteractor *interactor = [[SettingsScreenInteractor alloc] init];
    SettingsScreenPresenter *presenter = [[SettingsScreenPresenter alloc] init];
    
    view.interactor = interactor;
    interactor.presenter = presenter;
    presenter.view = view;
    
    return view;
}

@end
