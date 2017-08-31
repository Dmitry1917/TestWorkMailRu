//
//  SettingsScreenViewController.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 31.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "SettingsScreenViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)didMoveToParentViewController:(UIViewController *)parent {
    //NSLog(@"parentVC %@", parent);
}

-(void)updateModel:(SettingsViewModel *)settings {
    [self.showAvatarsSwitch setOn:settings.showAvatars animated:NO];
}

- (IBAction)showAvatarsChanged:(id)sender {
    [self.interactor setAvatarHidden:!((UISwitch*)sender).isOn];
}

@end
