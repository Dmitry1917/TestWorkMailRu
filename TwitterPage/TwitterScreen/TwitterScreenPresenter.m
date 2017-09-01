//
//  TwitterScreenPresenter.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterScreenPresenter.h"
#import "CommonDateFormatter.h"

@implementation TwitterScreenPresenter

-(void)updateModel:(NSArray <TweetViewModel*> *)tweets {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.view) return;
        [self.view updateModel:tweets];
    });
}

-(void)updateCounter:(int)number {
    NSString *counterText = @"";
    if (number > 0) counterText = [NSString stringWithFormat:@"%d", number];
    [self.view updateCounter:counterText];
}

@end
