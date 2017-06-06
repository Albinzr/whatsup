//
//  AuthUtil.swift
//  Logic
//
//  Created by Ankur Kesharwani on 31/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class AuthUtil {
    public class func saveAccessToken(token: String) {
        UserDefaults.standard.set(token, forKey: "access_token")
    }
    
    public class func getAccessToken() -> String? {
        return UserDefaults.standard.value(forKey: "access_token") as? String
    }
    
    public class func isLoggedIn() -> Bool {
        return getAccessToken() != nil
    }
}
