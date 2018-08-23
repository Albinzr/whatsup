//
//  AuthRequest.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class AuthRequest {
    public class Response {
        
        /// Will be set if request failed due to some reason.
        public var error: Error?
        
        /// Bearer token returned upon successful authentication.
        public var bearerToken: String?
        
        public init(from error: Error?) {
            self.error = error
        }
        
        public init(from response: WebAPIResponse?) {
            if response!.statusCode >= 200 && response!.statusCode < 300 {
                guard let dict = response?.response as? [String: Any?] else {
                    return
                }
                
                bearerToken = dict["bearer_token"] as? String
            } else {
                self.error = Exception.errorFor(code: response?.statusCode)
            }
        }
    }
    
    public init() {
        // Do nothing
    }
    
    public var basicToken: String!
    
    public func execute(onComplete: @escaping (Response) -> Void) {
        let request = WebAPIRequest()
        request.URLString = "https://api.twitter.com/oauth2/token"
        request.method = .post
        
        request.additionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
            "Authorization": basicToken]
        
        request.bodyParam = ["grant_type": "client_credentials"]
        request.requestSerializer = WebAPIRequestTwitterSerializer.self
        
        APIClient.shared.defaultAPIAdapter.request(request, successCallback: { (response) in
            onComplete(Response.init(from: response))
        }) { (error) in
            onComplete(Response.init(from: error))
        }
    }
}
