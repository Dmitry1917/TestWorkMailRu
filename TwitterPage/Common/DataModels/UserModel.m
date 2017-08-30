//
//  UserModel.m
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "UserModel.h"
#import "ParseFieldChecker.h"
#import "CommonDateFormatter.h"

@implementation UserModel

-(instancetype)initWithJSON:(NSDictionary*)JSON {
    self = [super initWithJSON:JSON];
    
    self.userID = [ParseFieldChecker checkStringOrDecimalNumberToString:JSON[@"id"]];
    self.name = [ParseFieldChecker fieldDataForJSONfield:JSON[@"name"]];
    self.screenName = [ParseFieldChecker fieldDataForJSONfield:JSON[@"screen_name"]];
    
    NSString *stringDate = [ParseFieldChecker fieldDataForJSONfield:JSON[@"created_at"]];
    if (stringDate) self.creationDate = [CommonDateFormatter dateFromServerString:stringDate];
    
    self.avatarUrlStr = [ParseFieldChecker fieldDataForJSONfield:JSON[@"profile_image_url_https"]];
    
    if (!self.userID) self.isIncorrect = YES;
    
    return self;
}

@end
