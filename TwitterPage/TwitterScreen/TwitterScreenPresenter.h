//
//  TwitterScreenPresenter.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterScreenProtocols.h"

@interface TwitterScreenPresenter : NSObject <TwitterScreenVIPPresenter>

@property(nonatomic, weak) NSObject <TwitterScreenVIPView> *view;

@end
