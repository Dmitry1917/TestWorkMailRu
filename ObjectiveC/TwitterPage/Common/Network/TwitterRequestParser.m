//
//  TwitterRequestParser.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterRequestParser.h"
#import "TweetModel.h"

@implementation TwitterRequestParser

+(NSArray <TweetModel*>*)parseTimeline:(id)JSON {
    if (![JSON isKindOfClass:[NSArray class]]) return nil;
    
    NSMutableArray <TweetModel*>* tweets = [NSMutableArray array];
    for (NSDictionary *tweetDict in JSON)
    {
        TweetModel *tweet = [[TweetModel alloc] initWithJSON:tweetDict];
        if (tweet && !tweet.isIncorrect) [tweets addObject:tweet];
    }
    return tweets;
}

@end
