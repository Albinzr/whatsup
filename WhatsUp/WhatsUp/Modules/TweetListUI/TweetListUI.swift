//
//  TweetListUI.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/31/2017.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import Logic

protocol TweetListUI: class, TwitterSearchManagerDelegate {
    static func newInstance() -> TweetListUI!

    var twitterSearchManager: TwitterSearchManager! { get set }
    
    func dismissUI()
}
