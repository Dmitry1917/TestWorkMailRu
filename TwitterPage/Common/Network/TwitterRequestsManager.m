//
//  TwitterRequestsManager.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TwitterRequestsManager.h"
#import "CommonNetworkManager.h"
#import "TwitterRequestSigner.h"
#import "TwitterRequestParser.h"

#define API_TIMEOUT 30.0
#define baseURL @"https://api.twitter.com/1.1/"

@implementation TwitterRequestsManager

+(void)askTimelineWithCompletionHandler:(void (^)(NSArray <TweetModel*> *tweets))completionHandler completionQueue:(dispatch_queue_t)completionQueue {
    NSString *resourceURL = @"statuses/home_timeline.json";//?count=1
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:resourceURL relativeToURL:[NSURL URLWithString:baseURL]]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:API_TIMEOUT];
    [request setHTTPMethod:@"GET"];
    
    [TwitterRequestSigner signRequest:request withRawPOSTParameters:nil];
    
    dispatch_queue_t queueForCompletion = completionQueue;
    if (!queueForCompletion) queueForCompletion = dispatch_get_main_queue();
    
    [[CommonNetworkManager shared] executeRequest:request withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        if (error) {
            dispatch_async(queueForCompletion, ^{ completionHandler(nil); });
            return;
        }
        
        if ([response isKindOfClass:NSHTTPURLResponse.class]) {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            
            if (httpResponse.statusCode == 200) {
                id JSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                //NSLog(@"result %@", JSON);
                NSArray <TweetModel*>* tweets = [TwitterRequestParser parseTimeline:JSON];
                dispatch_async(queueForCompletion, ^{ completionHandler(tweets); });
            }
            else {
                id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSLog(@"request error %@", json);
                
                dispatch_async(queueForCompletion, ^{ completionHandler(nil); });
            }
        }
    }];
}

@end
