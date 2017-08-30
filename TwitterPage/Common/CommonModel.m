//
//  CommonModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

-(instancetype)initWithJSON:(NSDictionary*)JSON {
    self = [super init];
    
    if (![JSON isKindOfClass:[NSDictionary class]]) self.isIncorrect = YES;
    
    return self;
}

@end
