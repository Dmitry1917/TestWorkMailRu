//
//  CommonModel.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject

@property BOOL isIncorrect;

-(instancetype)initWithJSON:(NSDictionary*)JSON;

@end
