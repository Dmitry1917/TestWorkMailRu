//
//  TwitterScreenViewController.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 12.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class TwitterScreenViewController: UIViewController {
    
    var interactor: TwitterScreenVIPInteractor!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        interactor.viewDidLoad()
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if (parent == nil) { self.interactor.viewDidDismissedOrPoped() }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TwitterScreenViewController: TwitterScreenVIPView {
    
}
