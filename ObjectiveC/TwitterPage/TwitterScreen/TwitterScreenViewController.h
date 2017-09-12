//
//  TwitterViewController.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterScreenProtocols.h"

@interface TwitterScreenViewController : UIViewController <TwitterScreenVIPView>

@property(nonatomic, strong) NSObject <TwitterScreenVIPInteractor> *interactor;

@end
