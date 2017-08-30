//
//  ParseFieldChecker.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "ParseFieldChecker.h"

@implementation ParseFieldChecker

+(NSString*)checkStringOrDecimalNumberToString:(id)checkedObject
{
    if ([checkedObject isKindOfClass:[NSString class]])
    {
        return checkedObject;
    }
    else if ([checkedObject isKindOfClass:[NSNumber class]])
    {
        if ([checkedObject isEqualToNumber:@(((NSNumber*)checkedObject).longLongValue)])
        {
            return [NSString stringWithFormat:@"%lld", ((NSNumber*)checkedObject).longLongValue];
        }
        else return nil;
    }
    else return nil;
}
+(NSNumber*)checkStringOrDecimalNumberToNumber:(id)checkedObject
{
    if ([checkedObject isKindOfClass:[NSNumber class]])
    {
        if ([checkedObject isEqualToNumber:@(((NSNumber*)checkedObject).longLongValue)])
        {
            return checkedObject;
        }
        else return nil;
    }
    else if ([checkedObject isKindOfClass:[NSString class]])
    {
        return @([(NSString*)checkedObject longLongValue]);
    }
    else return nil;
}

+(id)fieldDataForJSONfield:(id)field
{
    if (field)
    {
        return [[self class] fixNull:field];
    }
    else return nil;
}

+(id)fixNull:(id)someObject
{
    if ([someObject isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    return someObject;
}

@end
