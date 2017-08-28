//
//  TwitterScreenInteractor.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterScreenProtocols.h"

@interface TwitterScreenInteractor : NSObject <TwitterScreenVIPInteractor>

@property(nonatomic, strong) NSObject <TwitterScreenVIPPresenter> *presenter;

@end
