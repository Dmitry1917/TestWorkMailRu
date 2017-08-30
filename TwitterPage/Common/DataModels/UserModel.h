//
//  UserModel.h
//  TwitterPage
//
//  Created by DMITRY SINYOV on 30.08.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonModel.h"

@interface UserModel : CommonModel

@property NSString *userID;
@property NSString *name;
@property NSString *screenName;
@property NSString *avatarUrlStr;
@property NSDate *creationDate;

@end
