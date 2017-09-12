//
//  TwitterScreenRouter.swift
//  TwitterPageSWIFT
//
//  Created by DMITRY SINYOV on 12.09.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

import UIKit

class TwitterScreenRouter: NSObject {
    
    class func createTwitterScreenModule() -> UINavigationController {
        let storyboard = UIStoryboard(name:"TwitterScreen", bundle:Bundle.main)
        let navigationController = storyboard.instantiateViewController(withIdentifier:"TwitterScreenNC") as! UINavigationController
        
//        let view = navigationController.childViewControllers[0] as! TwitterScreenViewController;
//        let interactor = TwitterScreenInteractor()
//        let presenter = TwitterScreenPresenter()
//        view.interactor = interactor;
//        interactor.presenter = presenter;
//        presenter.view = view;
        
        return navigationController;
    }
    class func openSettingsFromViewController(sourceVC: UIViewController) {
        
    }

}
