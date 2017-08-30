//
//  CommonNetworkManager.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 29.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonNetworkManager : NSObject

+(instancetype)shared;
-(void)executeRequest:(NSURLRequest*)request withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@end
