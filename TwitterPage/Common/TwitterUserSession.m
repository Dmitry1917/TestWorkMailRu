//
//  TwitterUserSession.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterUserSession.h"

#define consumer_key @"8YdUDIGVbiNJgFb0IstjOZNZk"
#define consumer_secret @"qBuOp6XxKSuaAc8z4tCIX6rQAMLVAvNO5NgO2orQOkiPjZ7GJA"
#define oauth_access_token @"901749363067772929-z2QxR7OC63P47BmNAwKTnU4ZQatUbj0"
#define oauth_access_token_secret @"Y6bggbDdVjZsrbwzSZSdPr4QoQR4wX9JxbnnGDoTglIQI"

@implementation TwitterUserSession

+(instancetype)shared {
    static TwitterUserSession *_sharedInstance;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[TwitterUserSession alloc] init];
        
    });
    return _sharedInstance;
}

-(NSString*)consumerKey {
    return consumer_key;
}
-(NSString*)consumerSecret {
    return consumer_secret;
}
-(NSString*)accessToken {
    return oauth_access_token;
}
-(NSString*)accessTokenSecret {
    return oauth_access_token_secret;
}

@end
