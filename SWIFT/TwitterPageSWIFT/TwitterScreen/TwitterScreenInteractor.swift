//
//  TwitterScreenInteractor.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 12.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

class TwitterScreenInteractor: NSObject {
    
    var presenter: TwitterScreenVIPPresenter!
    
    //TODO: Можно не заменять, а пополнять список твитов загруженными, да и в целом усложнить логику работы, но для определения точного механизма требуется информация об экране и его функционале
    func updateTimeline() {
        TwitterRequestManager.askTimeline(completionHandler: { tweets in
            if (tweets == nil) { return }
            if (tweets!.count > 0) {
//                currentTweets = tweets;
//                //сохранить загруженное
//                [[LocalDataManager shared] addOrReplaceTweets:tweets];
//                
//                //отправить на показ
//                [self.presenter updateModel:[self preparePONSOModels]];
            }
            else {
                
            }
            
//            [self setupCounterTimer];
        }, completionQueue: nil)
    }
}

extension TwitterScreenInteractor: TwitterScreenVIPInteractor {
    func viewDidLoad() {
        updateTimeline()
    }
    
    func viewDidDismissedOrPoped() {
        
    }
}
