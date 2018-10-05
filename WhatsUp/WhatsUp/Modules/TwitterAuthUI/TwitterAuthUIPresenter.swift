//
//  TwitterAuthUI.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/30/2017.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import Logic

struct TwitterAuthUIInitParams {
    var twitterAuthManager: TwitterAuthManager?
}

protocol TwitterAuthUIPresenter {
    func initTwitterAuthUI(initParams: TwitterAuthUIInitParams) -> TwitterAuthUI
    func presentTwitterAuthUI(_ ui: TwitterAuthUI)
}

extension TwitterAuthUIPresenter {
    func initTwitterAuthUI(initParams: TwitterAuthUIInitParams) -> TwitterAuthUI {
        let viewController = TwitterAuthViewController.newInstance() as TwitterAuthUI
        viewController.manager = initParams.twitterAuthManager ?? TwitterAuthManagerDefaultImpl()
        viewController.manager.delegate = viewController
        
        return viewController
    }
}

extension TwitterAuthUIPresenter where Self: UIViewController {
    func presentTwitterAuthUI(_ ui: TwitterAuthUI) {
        let viewController = ui as! TwitterAuthViewController

        navigationController?.show(viewController, sender: nil)
    }
}

extension TwitterAuthUIPresenter where Self: AppDelegate {
    func presentTwitterAuthUI(_ ui: TwitterAuthUI) {
        let viewController = ui as! TwitterAuthViewController
        
        window?.rootViewController = viewController
    }
}

