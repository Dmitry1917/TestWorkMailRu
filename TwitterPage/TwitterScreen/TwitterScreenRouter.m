//
//  TwitterScreenRouter.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterScreenRouter.h"
#import "TwitterScreenViewController.h"
#import "TwitterScreenInteractor.h"
#import "TwitterScreenPresenter.h"

@implementation TwitterScreenRouter

+(UINavigationController*)createTwitterScreenModule {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TwitterScreenStoryboard" bundle:[NSBundle mainBundle]];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"TwitterScreenNavigation"];
    
    TwitterScreenViewController *view = navigationController.childViewControllers.firstObject;
    TwitterScreenInteractor *interactor = [[TwitterScreenInteractor alloc] init];
    TwitterScreenPresenter *presenter = [[TwitterScreenPresenter alloc] init];
    
    view.interactor = interactor;
    interactor.presenter = presenter;
    presenter.view = view;
    
    return navigationController;
}

@end
