//
//  TweetListUI.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/31/2017.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import Logic

struct TweetListUIInitParams {
    let twitterSearcghManager: TwitterSearchManager!
}

protocol TweetListUIPresenter {
    func initTweetListUI(initParams: TweetListUIInitParams) -> TweetListUI!
    func presentTweetListUI(_ ui: TweetListUI)
}

extension TweetListUIPresenter where Self: UIViewController {
    func initTweetListUI(initParams: TweetListUIInitParams) -> TweetListUI! {
        let viewController = TweetListViewController.newInstance() as TweetListUI
        viewController.twitterSearchManager = initParams.twitterSearcghManager
        viewController.twitterSearchManager.delegate = viewController
        
        return viewController
    }

    func presentTweetListUI(_ ui: TweetListUI) {
        let viewController = ui as! TweetListViewController

        navigationController?.show(viewController, sender: nil)
    }
}
