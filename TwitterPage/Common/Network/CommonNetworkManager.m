//
//  CommonNetworkManager.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 29.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "CommonNetworkManager.h"

@implementation CommonNetworkManager
{
    NSURLSession *session;
    NSOperationQueue *requestsQueue;
}

+(instancetype)shared {
    static CommonNetworkManager *_sharedInstance;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        
        _sharedInstance = [[CommonNetworkManager alloc] init];
        
    });
    return _sharedInstance;
}

-(instancetype)init {
    self = [super init];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    session = [NSURLSession sessionWithConfiguration:configuration];
    requestsQueue = [[NSOperationQueue alloc] init];
    requestsQueue.maxConcurrentOperationCount = 1;
    
    return self;
}

-(void)executeRequest:(NSURLRequest*)request withCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    //решение проблемы использования синхронного запроса в NSURLSession вместо NSURLConnection, который их поддерживал, с помощью семафоров оказалось официально одобренным Apple https://forums.developer.apple.com/thread/11519
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        //NSLog(@"requestsQueue count %ld", (long)requestsQueue.operationCount);
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
//            if ([response isKindOfClass:NSHTTPURLResponse.class]) {
//                
//                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
//                
//                if (httpResponse.statusCode == 200) {
//                    completionHandler(data, response, error);
//                }
//                else {
//                    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                    
//                    NSLog(@"request error %@", json);
//                }
//            }
            
            completionHandler(data, response, error);
            
            dispatch_semaphore_signal(semaphore);
        }];
        
        [dataTask resume];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }];
    
    [requestsQueue addOperation:operation];
}

@end
