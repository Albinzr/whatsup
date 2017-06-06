//
//  UserDetailsUI.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 06/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import PersistenceStore

protocol UserDialogUI {
    static func newInstance() -> UserDialogUI!
    
    var user: CDUser! { get set }
    
    func dismissUI()
}
