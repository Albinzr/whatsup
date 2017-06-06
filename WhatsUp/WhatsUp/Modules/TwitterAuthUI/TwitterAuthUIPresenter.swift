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
}

protocol TwitterAuthUIPresenter {
    func initTwitterAuthUI(initParams: TwitterAuthUIInitParams) -> TwitterAuthUI!
    func presentTwitterAuthUI(_ ui: TwitterAuthUI)
}

extension TwitterAuthUIPresenter where Self: UIViewController {
    func initTwitterAuthUI(initParams: TwitterAuthUIInitParams) -> TwitterAuthUI! {
        let viewController = TwitterAuthViewController.newInstance() as TwitterAuthUI
        viewController.manager = TwitterAuthManagerDefaultImpl()
        viewController.manager.delegate = viewController

        return viewController
    }

    func presentTwitterAuthUI(_ ui: TwitterAuthUI) {
        let viewController = ui as! TwitterAuthViewController

        navigationController?.show(viewController, sender: nil)
    }
}
