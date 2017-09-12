//
//  TwitterScreenInteractor.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 12.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class TwitterScreenInteractor: NSObject {
    
    var presenter: TwitterScreenVIPPresenter!

}

extension TwitterScreenInteractor: TwitterScreenVIPInteractor {
    func viewDidLoad() {
        
    }
    
    func viewDidDismissedOrPoped() {
        
    }
}
