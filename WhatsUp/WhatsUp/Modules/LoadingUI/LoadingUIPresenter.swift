//
//  LoadingUIPresenter.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

extension LoadingUIPresenter where Self: UIViewController {
    func initLoadingUI() -> LoadingUI {
        return LoadingView.newInstance()
    }
    
    func initLoadingUI(initParams: LoadingUIInitParams) -> LoadingUI {
        let loadingView = LoadingView.newInstance() as! LoadingView
        loadingView.lTitleLable.text = initParams.title
        loadingView.setAppearance(style: initParams.style ?? .dark)
        
        return loadingView
    }
    
    func presentLoadingUI(loadingUI: LoadingUI, in view: UIView) {
        let loadingView = loadingUI as! LoadingView
        loadingView.frame = view.bounds
        loadingView.alpha = 0
        view.addSubview(loadingView)
        UIView.animate(withDuration: 0.2) {
            loadingView.alpha = 1
        }
    }
    
    func dismissLoadingUI(loadingUI: LoadingUI) {
        let loadingView = loadingUI as! LoadingView
        UIView.animate(withDuration: 0.2, animations: {
            loadingView.alpha = 0
        }) { _ in
            loadingView.removeFromSuperview()
        }
    }
    
    func presentLoadingUIOnWindow() {
        presentLoadingUIOnWindow(message: "Loading")
    }
    
    func presentLoadingUIOnWindow(message: String) {
        DispatchQueue.main.async {
            let loadingView = LoadingView.sharedLoadingView as! LoadingView
            let window = UIApplication.shared.delegate?.window
            loadingView.frame = (window??.frame)!
            loadingView.lTitleLable.text = message
            if loadingView.count == 0 {
                window??.addSubview(loadingView)
            }
            loadingView.count = loadingView.count + 1
        }
    }
    
    func dismissLoadingViewFromWindow() {
        DispatchQueue.main.async {
            let loadingView = LoadingView.sharedLoadingView as! LoadingView
            loadingView.count = loadingView.count - 1
            
            if loadingView.count <= 0 {
                loadingView.removeFromSuperview()
                loadingView.count = 0
            }
        }
    }
}
