//
//  Client.swift
//  Services
//
//  Created by Ankur Kesharwani on 30/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class APIClient {
    var defaultAPIAdapter: WebAPIAdapter!
    var imageAPIAdapter: WebAPIAdapter!
    
    public static let shared: APIClient = APIClient()
    
    private init() {
        // So that no one can initialise the damn thing.

        defaultAPIAdapter = WebAPIAdapter.init(sessionConfiguration: nil) // Passing nil will create a default session.
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.urlCache = nil
        config.timeoutIntervalForRequest = 60
        
        imageAPIAdapter = WebAPIAdapter.init(sessionConfiguration: config)
    }
    
    public func setDefaultHeaders(headers: WebAPIRequest.Headers) {

        // Create a new session config
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        config.timeoutIntervalForRequest = 30
        config.httpAdditionalHeaders = headers
        
        // Create new default API adapter
        defaultAPIAdapter = WebAPIAdapter.init(sessionConfiguration: config)
    }
}
