//
//  AuthService.swift
//  Services
//
//  Created by Ankur Kesharwani on 30/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class AuthService {
    
    public class func authenticate(basicToken: String,
                      successCallback: @escaping ((_ response: WebAPIResponse) -> Void),
                      errorCallback: @escaping ((_ error: Error) -> Void)) {
        
        let request = WebAPIRequest()
        request.URLString = "https://api.twitter.com/oauth2/token"
        request.method = .post
        
        request.additionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
            "Authorization": basicToken]
        
        request.bodyParam = ["grant_type": "client_credentials"]
        request.requestSerializer = WebAPIRequestTwitterSerializer.self
        
        APIClient.shared.defaultAPIAdapter.request(request, successCallback: successCallback, errorCallback: errorCallback)
    }
}
