//
//  SettingsScreenViewController.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsScreenViewController.h"
#import "SettingsViewModel.h"

@interface SettingsScreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showAvatarsLabel;
@property (weak, nonatomic) IBOutlet UISwitch *showAvatarsSwitch;

@end

@implementation SettingsScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.interactor viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didMoveToParentViewController:(UIViewController *)parent {
    //NSLog(@"parentVC %@", parent);
}

-(void)updateModel:(SettingsViewModel *)settings {
    [self.showAvatarsSwitch setOn:settings.showAvatars animated:NO];
}

- (IBAction)showAvatarsChanged:(id)sender {
    [self.interactor setAvatarsHidden:!((UISwitch*)sender).isOn];
}

@end
