//
//  TwitterAuthUI.swift
//  Logic
//
//  Created by Ankur Kesharwani on 05/30/2017.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation


public enum TwitterAuthManagerError: Error {
    case urlEncodeException
    case base64EncodeException
    case nilAccessToken
    case statusNotOk
}


public protocol TwitterAuthManagerDelegate: class {
    func authSuccessfull(manager: TwitterAuthManager)
    func twitterAuthManager(_ manager: TwitterAuthManager, authFailedWithError error: Error?)
}

public protocol TwitterAuthManager: class {
    var delegate: TwitterAuthManagerDelegate? { get set }
    
    func authenticate(consumerKey: String, secretKey: String)
}
