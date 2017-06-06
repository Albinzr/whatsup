//
//  TwitterAuthUI.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/30/2017.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import Logic

protocol TwitterAuthUI: class, TwitterAuthManagerDelegate {
    static func newInstance() -> TwitterAuthUI!

    var manager: TwitterAuthManager! { get set }

    func dismissUI()
}
