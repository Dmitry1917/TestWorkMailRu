//
//  TwitterRequestSigner.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#pragma mark Взято из STTwitter

#import <Foundation/Foundation.h>

@interface TwitterRequestSigner : NSObject

+(void)signRequest:(NSMutableURLRequest*)request withRawPOSTParameters:(NSDictionary*)rawPOSTParameters;

@end
