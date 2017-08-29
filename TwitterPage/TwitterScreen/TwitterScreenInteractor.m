//
//  TwitterScreenInteractor.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterScreenInteractor.h"
#import "CommonNetworkManager.h"

@implementation TwitterScreenInteractor

-(void)viewDidLoad {
    [_presenter updateModel];
    
    [[CommonNetworkManager shared] askTimelineWithCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        id JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result %@", JSON);
    }];
}

@end
