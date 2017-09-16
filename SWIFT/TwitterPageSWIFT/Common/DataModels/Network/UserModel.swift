//
//  UserModel.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 15.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class UserModel: CommonModel {
    
    var userID:String? = nil
    var name:String? = nil
    var screenName:String? = nil
    var avatarUrlStr:String? = nil
    var creationDate:Date? = nil
    
    override init(json: [String: AnyObject]) {
        super.init(json: json)
        
        self.userID = ParseFieldChecker.checkStringOrDecimalNumberToString(checkedObject: json["id"])
        self.name = ParseFieldChecker.fieldDataForJSON(field: json["name"] as? String)
        self.screenName = ParseFieldChecker.fieldDataForJSON(field: json["screen_name"] as? String)
        
        let stringDate = ParseFieldChecker.fieldDataForJSON(field: json["created_at"] as? String)
        if (stringDate != nil) { self.creationDate = CommonDateFormatter.dateFromServerString(serverString: stringDate!) }
        
        self.avatarUrlStr = ParseFieldChecker.fieldDataForJSON(field: json["profile_image_url_https"] as? String)
        
        if (self.userID == nil) { self.isIncorrect = true }
    }

}
