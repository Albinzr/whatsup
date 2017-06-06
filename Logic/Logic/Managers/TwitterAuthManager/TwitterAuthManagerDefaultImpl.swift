//
//  TwitterAuthManagerDefaultImpl.swift
//  Logic
//
//  Created by Ankur Kesharwani on 31/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import Services


public class TwitterAuthManagerDefaultImpl: TwitterAuthManager {
    public weak var delegate: TwitterAuthManagerDelegate?
    
    public init() {}
    
    public func authenticate(consumerKey: String, secretKey: String) {
        let encodedConsumerKey = urlEncode(string: consumerKey)
        let encodedSecretKey = urlEncode(string: secretKey)
        
        guard encodedConsumerKey != nil && encodedSecretKey != nil else {
            delegate?.twitterAuthManager(self, authFailedWithError: TwitterAuthManagerError.urlEncodeException)
            
            return
        }
        
        let token = "\(encodedConsumerKey!):\(encodedSecretKey!)"
        let encodedToken = base64Encode(string: token)
        
        guard encodedToken != nil else {
            delegate?.twitterAuthManager(self, authFailedWithError: TwitterAuthManagerError.base64EncodeException)
            
            return
        }
        
        let basicToken = "Basic \(encodedToken!)"
        
        AuthService.authenticate(basicToken: basicToken, successCallback: { (response) in
            if response.statusCode == 200 {
                let responseJSON = response.response as! [String: String]
                if let bearerToken = responseJSON["access_token"] {
                    AuthUtil.saveAccessToken(token: bearerToken)
                    APIClient.shared.setDefaultHeaders(headers: ["Authorization": "Bearer \(bearerToken)"])
                    
                    self.delegate?.authSuccessfull(manager: self)
                } else {
                    self.delegate?.twitterAuthManager(self, authFailedWithError: TwitterAuthManagerError.nilAccessToken)
                }
            } else  {
                self.delegate?.twitterAuthManager(self, authFailedWithError: TwitterAuthManagerError.statusNotOk)
            }
        }, errorCallback: { (error) in
            self.delegate?.twitterAuthManager(self, authFailedWithError: error)
        })
    }
    
    private func urlEncode(string: String) -> String? {
        return string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    private func base64Encode(string: String) -> String? {
        if let data = (string).data(using: String.Encoding.utf8) {
            return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        }
        
        return nil
    }
}
