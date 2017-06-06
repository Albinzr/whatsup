//
//  File.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

enum LoadingUIAppearance {
    case dark
    case light
}

protocol LoadingUI {
    static func newInstance() -> LoadingUI
}

struct LoadingUIInitParams {
    var title: String
    var style: LoadingUIAppearance?
}

protocol LoadingUIPresenter: class {
    func initLoadingUI(initParams: LoadingUIInitParams) -> LoadingUI
    
    func presentLoadingUI(loadingUI: LoadingUI, in view: UIView)
    func dismissLoadingUI(loadingUI: LoadingUI)
    
    func presentLoadingUIOnWindow(message: String)
    func dismissLoadingViewFromWindow()
}
