//
//  TweetModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TweetModel.h"
#import "ParseFieldChecker.h"
#import "CommonDateFormatter.h"

@implementation TweetModel

-(instancetype)initWithJSON:(NSDictionary*)JSON {
    self = [super initWithJSON:JSON];
    
    self.tweetID = [ParseFieldChecker checkStringOrDecimalNumberToString:JSON[@"id"]];
    self.text = [ParseFieldChecker fieldDataForJSONfield:JSON[@"text"]];
    
    NSString *stringDate = [ParseFieldChecker fieldDataForJSONfield:JSON[@"created_at"]];
    if (stringDate) self.date = [CommonDateFormatter dateFromServerString:stringDate];
    
    NSNumber *favorited = [ParseFieldChecker checkStringOrDecimalNumberToNumber:JSON[@"favorited"]];
    if (favorited) self.favorited = favorited.boolValue;
    
    NSDictionary *userDict = [ParseFieldChecker fieldDataForJSONfield:JSON[@"user"]];
    
    if (userDict) self.user = [[UserModel alloc] initWithJSON:userDict];
    
    if (!self.tweetID || !self.user || self.user.isIncorrect) self.isIncorrect = YES;
    
    return self;
}

@end
