//
//  TwitterRequestsManager.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TweetModel;

@interface TwitterRequestsManager : NSObject

+(void)askTimelineWithCompletionHandler:(void (^)(NSArray <TweetModel*> *tweets))completionHandler;

@end
