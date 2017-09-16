//
//  TwitterRequestManager.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 15.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

let API_TIMEOUT = 30.0
let baseURL = "https://api.twitter.com/1.1/"

import UIKit

class TwitterRequestManager: NSObject {
    class func askTimeline(completionHandler: @escaping ([TweetModel]?)->Void, completionQueue:DispatchQueue?) {
        let resourceURL = "statuses/home_timeline.json"//?count=1
        var request = URLRequest(url: URL(string: resourceURL, relativeTo: URL(string: baseURL))!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: API_TIMEOUT)
        request.httpMethod = "GET"
        
        let authHeaders = TwitterRequestSigner.sign(request, withRawPOSTParameters: nil)
        for (key, value) in authHeaders! {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        var queueForCompletion = completionQueue
        if (queueForCompletion == nil) { queueForCompletion = DispatchQueue.main }
        
        CommonNetworkManager.shared.execute(request: request, completionHandler: { (data, response, error) in
            if (error != nil) {
                queueForCompletion?.async { completionHandler(nil) }
                return
            }
            
            if (response is HTTPURLResponse) {
                let httpResponse = response as? HTTPURLResponse
                
                if (httpResponse?.statusCode == 200) {
                    guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) else {
                        print("cant parse into json")
                        return
                    }
                    
                    let tweets = TwitterRequestParser.parseTimeline(json: json)
                    queueForCompletion?.async { completionHandler(tweets) }
                }
                else {
                    let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    print("request error %@", json ?? "empty")
                    queueForCompletion?.async { completionHandler(nil) }
                }
            }
        })
    }
}
