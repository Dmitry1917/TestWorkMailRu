//
//  TweetTableViewCell.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TweetTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillWithViewModel:(TweetViewModel *)model {
    [self.userNameLabel setText:model.user.name];
    [self.screenNameLabel setText:model.user.screenName];
    [self.dateLabel setText:model.formattedDate];
    [self.tweetLabel setText:model.text];
    [self.favoriteButton setImage:model.favorited ? [UIImage imageNamed:@"favorite"] : [UIImage imageNamed:@"unfavorite"] forState:UIControlStateNormal];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.user.avatarUrlStr] placeholderImage:[UIImage imageNamed:@"avatarDefault"]];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2.0;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (IBAction)favoriteButtonTaped:(id)sender {
}

@end
