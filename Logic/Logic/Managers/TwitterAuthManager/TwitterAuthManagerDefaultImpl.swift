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
        
        let authRequest = AuthRequest.init()
        authRequest.basicToken = basicToken
        authRequest.execute { (response) in
            if response.error != nil {
                if let serviceError = response.error as? ServiceError {
                    self.delegate?.twitterAuthManager(self,
                                                        authFailedWithError: serviceError)
                    
                    return
                }
                
                self.delegate?.twitterAuthManager(self, authFailedWithError: response.error)
                
                return
            }
            
            if response.bearerToken == nil {
                self.delegate?.twitterAuthManager(self, authFailedWithError: TwitterAuthManagerError.nilAccessToken)
                
                return
            }
            
            AuthUtil.saveAccessToken(token: response.bearerToken!)
            APIClient.shared.setDefaultHeaders(headers: ["Authorization": "Bearer \(response.bearerToken!)"])
            
            self.delegate?.authSuccessfull(manager: self)
        }
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
