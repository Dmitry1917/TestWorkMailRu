//
//  TwitterScreenViewController.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterScreenViewController.h"
#import "TweetTableViewCell.h"

#define defaultCellHeight 60.0

@interface TwitterScreenViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
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
    
    [_interactor viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateModel:(NSArray<TweetViewModel *> *)tweets {
    tweetsModel = tweets;
    //NSLog(@"tweets %@", tweets);
    
    [self.tweetsTableView reloadData];
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

@end
