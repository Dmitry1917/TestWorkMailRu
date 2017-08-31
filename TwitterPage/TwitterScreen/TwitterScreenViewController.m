//
//  TwitterScreenViewController.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterScreenViewController.h"
#import "TweetTableViewCell.h"

#import "TwitterScreenRouter.h"

#define defaultCellHeight 90.0

@interface TwitterScreenViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@end

@implementation TwitterScreenViewController
{
    NSArray <TweetViewModel*> *tweetsModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tweetsTableView.delegate = self;
    self.tweetsTableView.dataSource = self;
    
    [self.tweetsTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TweetTableViewCell"];
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    self.tweetsTableView.estimatedRowHeight = defaultCellHeight;
    
    [self.interactor viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didMoveToParentViewController:(UIViewController *)parent {
    if (!parent) [self.interactor viewDidDismissedOrPoped];
}

-(void)updateModel:(NSArray<TweetViewModel *> *)tweets {
    tweetsModel = tweets;
    //NSLog(@"tweets %@", tweets);
    
    [self.tweetsTableView reloadData];
}

-(void)updateCounter:(NSString *)counterText {
    [self.timerLabel setText:counterText];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tweetsModel.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    TweetViewModel *modelForCell = tweetsModel[indexPath.row];
    [cell fillWithViewModel:modelForCell];
    
    return cell;
}

- (IBAction)settingsButtonTouched:(id)sender {
    [TwitterScreenRouter openSettingsFromViewController:self];
}

@end
