//
//  ParseFieldChecker.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseFieldChecker : NSObject

+(NSString*)checkStringOrDecimalNumberToString:(id)checkedObject;
+(NSNumber*)checkStringOrDecimalNumberToNumber:(id)checkedObject;
+(id)fieldDataForJSONfield:(id)field;

@end
