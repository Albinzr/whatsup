//
//  UserDialogUIPresenter.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 06/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import PersistenceStore

struct UserDialogUIInitParams {
    let user: CDUser!
}

protocol UserDialogUIPresenter {
    func initUserDialogUI(initParams: UserDialogUIInitParams) -> UserDialogUI
    func presentUserDialogUI(_ ui: UserDialogUI)
}

extension UserDialogUIPresenter where Self: UIViewController {
    func initUserDialogUI(initParams: UserDialogUIInitParams) -> UserDialogUI {
        var view = UserDialogView.newInstance() as UserDialogUI
        view.user = initParams.user
        
        return view
    }
    
    func presentUserDialogUI(_ ui: UserDialogUI) {
        let dialogView = ui as! UIView
        dialogView.alpha = 0
        
        let window = UIApplication.shared.delegate?.window!!
        dialogView.frame = (window?.frame)!
        
        window?.addSubview(dialogView)
        UIView.animate(withDuration: 0.2) { 
            dialogView.alpha = 1.0
        }
    }
}

