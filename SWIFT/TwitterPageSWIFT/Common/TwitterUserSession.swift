//
//  TwitterUserSession.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 16.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

let consumer_key = "8YdUDIGVbiNJgFb0IstjOZNZk"
let consumer_secret = "qBuOp6XxKSuaAc8z4tCIX6rQAMLVAvNO5NgO2orQOkiPjZ7GJA"
let oauth_access_token = "901749363067772929-z2QxR7OC63P47BmNAwKTnU4ZQatUbj0"
let oauth_access_token_secret = "Y6bggbDdVjZsrbwzSZSdPr4QoQR4wX9JxbnnGDoTglIQI"

class TwitterUserSession: NSObject {
    static let shared = TwitterUserSession()
    
    let consumerKey = {
        return consumer_key
    }()
    let consumerSecret = {
        return consumer_secret
    }()
    let accessToken = {
        return oauth_access_token
    }()
    let accessTokenSecret = {
        return oauth_access_token_secret
    }()
}
