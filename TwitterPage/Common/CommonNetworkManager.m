//
//  CommonNetworkManager.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 29.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "CommonNetworkManager.h"

#include <CommonCrypto/CommonHMAC.h>

#define API_TIMEOUT 30.0
#define baseURL @"https://api.twitter.com/1.1/"

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

-(void)askTimelineWithCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    NSString *resourceURL = @"statuses/home_timeline.json";//?count=1
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:resourceURL relativeToURL:[NSURL URLWithString:baseURL]]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:API_TIMEOUT];
    [request setHTTPMethod:@"GET"];
    
    //#warning тут будет очередь запросов
    //решение проблемы использования синхронного запроса в NSURLSession вместо NSURLConnection, который их поддерживал, с помощью семафоров оказалось официально одобренным Apple https://forums.developer.apple.com/thread/11519
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        //NSLog(@"requestsQueue count %ld", (long)requestsQueue.operationCount);
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        
        NSDictionary <NSString *, NSString *> *authHeaders = @{ @"oauth_access_token" : @"901749363067772929-z2QxR7OC63P47BmNAwKTnU4ZQatUbj0",
                                                                @"oauth_access_token_secret" : @"Y6bggbDdVjZsrbwzSZSdPr4QoQR4wX9JxbnnGDoTglIQI",
                                                                @"consumer_key" : @"8YdUDIGVbiNJgFb0IstjOZNZk",
                                                                @"consumer_secret" : @"qBuOp6XxKSuaAc8z4tCIX6rQAMLVAvNO5NgO2orQOkiPjZ7GJA" };
        
//        for (NSString *key in authHeaders.allKeys) {
//            [request addValue:authHeaders[key] forHTTPHeaderField:key];
//        }
        
        [self signRequest:request withRawParameters:nil];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if ([response isKindOfClass:NSHTTPURLResponse.class]) {
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                
                NSDictionary *headers = httpResponse.allHeaderFields;
                
                //NSString *strDate = headers[@"Date"];
                
                if (httpResponse.statusCode == 200) {
                    completionHandler(data, response, error);
                }
                else {
                    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    NSLog(@"request error %@", json);
                }
            }
            
            dispatch_semaphore_signal(semaphore);
        }];
        
        [dataTask resume];
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }];
    
    [requestsQueue addOperation:operation];
}

#define consumerKey @"8YdUDIGVbiNJgFb0IstjOZNZk"
#define consumer_secret @"qBuOp6XxKSuaAc8z4tCIX6rQAMLVAvNO5NgO2orQOkiPjZ7GJA"
#define oauth_access_token @"901749363067772929-z2QxR7OC63P47BmNAwKTnU4ZQatUbj0"
#define oauth_access_token_secret @"Y6bggbDdVjZsrbwzSZSdPr4QoQR4wX9JxbnnGDoTglIQI"

-(void)signRequest:(NSMutableURLRequest*)request withRawParameters:(NSDictionary*)rawParameters {
    NSMutableArray *oauthParameters = [NSMutableArray arrayWithObjects:
                                       @{@"oauth_consumer_key"     : consumerKey},
                                       @{@"oauth_nonce"            : [self st_random32Characters]},
                                       @{@"oauth_signature_method" : [self oauthSignatureMethod]},
                                       @{@"oauth_timestamp"        : [self oauthTimestamp]},
                                       @{@"oauth_version"          : [self oauthVersion]},
                                       @{@"oauth_token" : oauth_access_token}, nil];
    
    
    NSMutableArray *oauthAndPOSTParameters = [oauthParameters mutableCopy];
    
    if(rawParameters) {
        [rawParameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [oauthAndPOSTParameters addObject:@{ key : obj }];
        }];
    }
    
    NSMutableArray *oauthAndPOSTandGETParameters = [[self st_rawGetParametersDictionariesFromURL:request.URL] mutableCopy];
    [oauthAndPOSTandGETParameters addObjectsFromArray:oauthAndPOSTParameters];
    
    [rawParameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSDictionary *d = @{key:obj};
        [oauthAndPOSTandGETParameters addObject:d];
    }];
    
    NSString *signature = [self oauthSignatureWithHTTPMethod:request.HTTPMethod
                                                                 url:request.URL
                                                          parameters:oauthAndPOSTandGETParameters
                                                      consumerSecret:consumer_secret
                                                         tokenSecret:oauth_access_token_secret];
    
    [oauthParameters addObject:@{@"oauth_signature" : signature}];
    
    NSString *s = [self oauthHeaderValueWithParameters:oauthParameters];
    
    [request setValue:s forHTTPHeaderField:@"Authorization"];
}

- (NSString *)st_randomString {
    CFUUIDRef cfuuid = CFUUIDCreate (kCFAllocatorDefault);
    NSString *uuid = (__bridge_transfer NSString *)(CFUUIDCreateString (kCFAllocatorDefault, cfuuid));
    CFRelease (cfuuid);
    return uuid;
}

- (NSString *)st_random32Characters {
    NSString *randomString = [self st_randomString];
    
    NSAssert([randomString length] >= 32, @"");
    
    return [randomString substringToIndex:32];
}

- (NSArray *)st_rawGetParametersDictionariesFromURL:(NSURL*)url {
    
    NSString *q = [url query];
    
    NSArray *getParameters = [q componentsSeparatedByString:@"&"];
    
    NSMutableArray *ma = [NSMutableArray array];
    
    for(NSString *s in getParameters) {
        NSArray *kv = [s componentsSeparatedByString:@"="];
        NSAssert([kv count] == 2, @"-- bad length");
        if([kv count] != 2) continue;
        NSString *value = [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; // use raw parameters for signing
        [ma addObject:@{kv[0] : value}];
    }
    
    return ma;
}

- (NSString *)oauthSignatureMethod {
    return @"HMAC-SHA1";
}

- (NSString *)oauthTimestamp {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%d", (int)timeInterval];
}

- (NSString *)oauthVersion {
    return @"1.0";
}

- (NSString *)oauthSignatureWithHTTPMethod:(NSString *)httpMethod url:(NSURL *)url parameters:(NSArray *)parameters consumerSecret:(NSString *)consumerSecret tokenSecret:(NSString *)tokenSecret {
    /*
     The oauth_signature parameter contains a value which is generated by running all of the other request parameters and two secret values through a signing algorithm. The purpose of the signature is so that Twitter can verify that the request has not been modified in transit, verify the application sending the request, and verify that the application has authorization to interact with the user's account.
     https://dev.twitter.com/docs/auth/creating-signature
     */
    
    NSString *signatureBaseString = [self signatureBaseStringWithHTTPMethod:httpMethod url:url allParametersUnsorted:parameters];
    
    /*
     Note that there are some flows, such as when obtaining a request token, where the token secret is not yet known. In this case, the signing key should consist of the percent encoded consumer secret followed by an ampersand character '&'.
     */
    
    NSString *encodedConsumerSecret = [self st_urlEncodedString:consumerSecret];
    NSString *encodedTokenSecret = [self st_urlEncodedString:tokenSecret];
    
    NSString *signingKey = [NSString stringWithFormat:@"%@&", encodedConsumerSecret];
    
    if(encodedTokenSecret) {
        signingKey = [signingKey stringByAppendingString:encodedTokenSecret];
    }
    
    NSString *oauthSignature = [self st_signString:signatureBaseString HmacSHA1WithKey:signingKey];
    
    return oauthSignature;
}



- (NSString *)st_signString:(NSString*)string HmacSHA1WithKey:(NSString *)key {
    
    unsigned char buf[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, [key UTF8String], [key length], [string UTF8String], [string length], buf);
    NSData *data = [NSData dataWithBytes:buf length:CC_SHA1_DIGEST_LENGTH];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)st_stringByAddingRFC3986PercentEscapesUsingEncoding:(NSStringEncoding)encoding string:(NSString*)string {
    
    NSString *s = (__bridge_transfer NSString *)(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                         (CFStringRef)string,
                                                                                         NULL,
                                                                                         CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                         kCFStringEncodingUTF8));
    return s;
}
- (NSString *)st_urlEncodedString:(NSString*)string {
    
    return [self st_stringByAddingRFC3986PercentEscapesUsingEncoding:NSUTF8StringEncoding string:string];
}
- (NSArray *)encodedParametersDictionaries:(NSArray *)parameters {
    
    NSMutableArray *encodedParameters = [NSMutableArray array];
    
    for(NSDictionary *d in parameters) {
        
        NSString *key = [[d allKeys] lastObject];
        NSString *value = [[d allValues] lastObject];
        
        NSString *encodedKey = [self st_urlEncodedString:key];
        NSString *encodedValue = [self st_urlEncodedString:value];
        
        [encodedParameters addObject:@{encodedKey : encodedValue}];
    }
    
    return encodedParameters;
}

- (NSString *)stringFromParametersDictionaries:(NSArray *)parametersDictionaries {
    
    NSMutableArray *parameters = [NSMutableArray array];
    
    for(NSDictionary *d in parametersDictionaries) {
        
        NSString *encodedKey = [[d allKeys] lastObject];
        NSString *encodedValue = [[d allValues] lastObject];
        
        NSString *s = [NSString stringWithFormat:@"%@=\"%@\"", encodedKey, encodedValue];
        
        [parameters addObject:s];
    }
    
    return [parameters componentsJoinedByString:@", "];
}

- (NSString *)oauthHeaderValueWithParameters:(NSArray *)parametersDictionaries {
    
    NSArray *encodedParametersDictionaries = [self encodedParametersDictionaries:parametersDictionaries];
    
    NSString *encodedParametersString = [self stringFromParametersDictionaries:encodedParametersDictionaries];
    
    NSString *headerValue = [NSString stringWithFormat:@"OAuth %@", encodedParametersString];
    
    return headerValue;
}

- (NSString *)signatureBaseStringWithHTTPMethod:(NSString *)httpMethod url:(NSURL *)url allParametersUnsorted:(NSArray *)parameters {
    NSMutableArray *allParameters = [NSMutableArray arrayWithArray:parameters];
    
    NSArray *encodedParametersDictionaries = [self encodedParametersDictionaries:allParameters];
    
    NSArray *sortedEncodedParametersDictionaries = [self parametersDictionariesSortedByKey:encodedParametersDictionaries];
    
    /**/
    
    NSMutableArray *encodedParameters = [NSMutableArray array];
    
    for(NSDictionary *d in sortedEncodedParametersDictionaries) {
        NSString *encodedKey = [[d allKeys] lastObject];
        NSString *encodedValue = [[d allValues] lastObject];
        
        NSString *s = [NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue];
        
        [encodedParameters addObject:s];
    }
    
    NSString *encodedParametersString = [encodedParameters componentsJoinedByString:@"&"];
    
    NSString *signatureBaseString = [NSString stringWithFormat:@"%@&%@&%@",
                                     [httpMethod uppercaseString],
                                     [self st_urlEncodedString:[self st_normalizedForOauthSignatureStringFromURL:url]],
                                     [self st_urlEncodedString:encodedParametersString]];
    
    return signatureBaseString;
}

- (NSArray *)parametersDictionariesSortedByKey:(NSArray *)parametersDictionaries {
    
    return [parametersDictionaries sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSDictionary *d1 = (NSDictionary *)obj1;
        NSDictionary *d2 = (NSDictionary *)obj2;
        
        NSString *key1 = [[d1 allKeys] lastObject];
        NSString *key2 = [[d2 allKeys] lastObject];
        
        return [key1 compare:key2];
    }];
    
}

- (NSString *)st_normalizedForOauthSignatureStringFromURL:(NSURL*)url {
    return [NSString stringWithFormat:@"%@://%@%@", [url scheme], [url host], [url path]];
}


@end
