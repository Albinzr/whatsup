//
//  Env.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 02/07/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public enum EnvironmentKey {
    case consumerKey
    case secretKey
    
    func value() -> String {
        switch self {
        case .consumerKey:
            return "consumerKey"
        case .secretKey:
            return "secretKey"
        }
    }
}

public class Environment {
    private static var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Info plist file not found.")
            }
        }
    }
    
    public class func configuration(_ key: EnvironmentKey) -> String {
        switch key {
        case .consumerKey:
            return Environment.infoDict[EnvironmentKey.consumerKey.value()] as! String
        case .secretKey:
            return Environment.infoDict[EnvironmentKey.secretKey.value()] as! String
        }
    }
}
