//
//  TwitterRequestParser.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 16.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class TwitterRequestParser: NSObject {
    class func parseTimeline(json: Any?) -> [TweetModel]? {
        if (json == nil) { return nil }
        if (!(json is [[String: AnyObject]]?)) { return nil }
        var tweets = [TweetModel]()
        for tweetDict in json as! [[String: AnyObject]] {
            let tweet = TweetModel(json: tweetDict)
            if (!tweet.isIncorrect) { tweets.append(tweet) }
        }
        return tweets
    }
}
