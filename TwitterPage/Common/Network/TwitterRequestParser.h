//
//  TwitterRequestParser.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetModel.h"

@interface TwitterRequestParser : NSObject

+(NSArray <TweetModel*>*)parseTimeline:(id)JSON;

@end
