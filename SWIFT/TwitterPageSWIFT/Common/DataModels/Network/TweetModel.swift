//
//  TweetModel.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 15.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class TweetModel: CommonModel {
    
    var tweetID:String? = nil
    var text:String? = nil
    var date:Date? = nil
    var favorited = false
    var user:UserModel? = nil
    
    override init(json: [String: AnyObject]) {
        super.init(json: json)
        
        self.tweetID = ParseFieldChecker.checkStringOrDecimalNumberToString(checkedObject: json["id"])
        
        self.text = ParseFieldChecker.fieldDataForJSON(field: json["text"] as? String)
        
        let stringDate = ParseFieldChecker.fieldDataForJSON(field: json["created_at"] as? String)
        if (stringDate != nil) { self.date = CommonDateFormatter.dateFromServerString(serverString: stringDate!) }
        
        let favorited = ParseFieldChecker.checkStringOrDecimalNumberToNumber(checkedObject: json["favorited"])
        if (favorited != nil) { self.favorited = favorited!.boolValue }
        
        let userDict = ParseFieldChecker.fieldDataForJSON(field:json["user"])
        
        if (userDict != nil) { self.user = UserModel(json: userDict as! [String: AnyObject]) }
        
        if (self.tweetID == nil || self.user == nil || (self.user != nil && self.user!.isIncorrect)) { self.isIncorrect = true }
    }

}
