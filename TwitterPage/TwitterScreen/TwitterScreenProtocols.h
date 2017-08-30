//
//  TwitterScreenProtocols.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#ifndef TwitterScreenProtocols_h
#define TwitterScreenProtocols_h
#import "TweetViewModel.h"

@protocol TwitterScreenVIPView <NSObject>

-(void)updateModel:(NSArray <TweetViewModel*> *)tweets;

@end

@protocol TwitterScreenVIPInteractor <NSObject>

-(void)viewDidLoad;

@end

@protocol TwitterScreenVIPPresenter <NSObject>

-(void)updateModel:(NSArray <TweetViewModel*> *)tweets;

@end

#endif /* TwitterScreenProtocols_h */
