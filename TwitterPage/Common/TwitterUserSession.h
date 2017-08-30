//
//  TwitterUserSession.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterUserSession : NSObject

+(instancetype)shared;

-(NSString*)consumerKey;
-(NSString*)consumerSecret;
-(NSString*)accessToken;
-(NSString*)accessTokenSecret;

@end
