//
//  TwitterNetworkManager.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 12.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class CommonNetworkManager: NSObject {
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()
    private let requestQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    static let shared = CommonNetworkManager()
    
    func execute(request: URLRequest, completionHandler:@escaping (Data?, URLResponse?, Error?)->Void) {
        //решение проблемы использования синхронного запроса в NSURLSession вместо NSURLConnection, который их поддерживал, с помощью семафоров оказалось официально одобренным Apple https://forums.developer.apple.com/thread/11519
        let operation = BlockOperation(block:{
            let semaphore = DispatchSemaphore(value: 0)
            
            let dataTask = self.session.dataTask(with: request, completionHandler: {
                (data, response, error) in
                
                completionHandler(data, response, error)
                semaphore.signal()
            })
            dataTask.resume()
            if (semaphore.wait(timeout: DispatchTime.distantFuture) == .timedOut) { print("Something wrong with requests queue") }
        })
        
        requestQueue.addOperation(operation)
    }
}
