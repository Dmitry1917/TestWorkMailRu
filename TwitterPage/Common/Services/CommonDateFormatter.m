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
    static NSDateComponentsFormatter *dateComponentsFormatter;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        dateComponentsFormatter = [[NSDateComponentsFormatter alloc] init];
        dateComponentsFormatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
        dateComponentsFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropAll;
        dateComponentsFormatter.maximumUnitCount = 1;
        dateComponentsFormatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    });
    
    return [dateComponentsFormatter stringFromDate:date toDate:[NSDate date]];
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
