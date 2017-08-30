//
//  TweetModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TweetModel.h"
#import "ParseFieldChecker.h"

@implementation TweetModel

-(instancetype)initWithJSON:(NSDictionary*)JSON {
    self = [super initWithJSON:JSON];
    
    self.tweetID = [ParseFieldChecker checkStringOrDecimalNumberToString:JSON[@"id"]];
    
    return self;
}

@end
