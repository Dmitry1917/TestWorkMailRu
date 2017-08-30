//
//  CommonDateFormatter.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 28.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "CommonDateFormatter.h"

@implementation CommonDateFormatter

+(NSString*)formattedTweetDate:(NSDate*)date {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.doesRelativeDateFormatting = YES;
    });
    
    return [dateFormatter stringFromDate:date];
}

+(NSDate*)dateFromServerString:(NSString*)serverString {
    static NSDateFormatter *serverDateFormatter;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        serverDateFormatter = [[NSDateFormatter alloc] init];
        serverDateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
        serverDateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"US"];
    });
    
    return [serverDateFormatter dateFromString:serverString];
}

@end
