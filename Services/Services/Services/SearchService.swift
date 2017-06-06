//
//  SearchService.swift
//  Services
//
//  Created by Ankur Kesharwani on 01/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class SearchService {
    
    public class func search(queryParams: WebAPIRequest.QueryParam,
                             successCallback: @escaping ((_ response: WebAPIResponse) -> Void),
                             errorCallback: @escaping ((_ error: Error) -> Void)) {
        
        let request = WebAPIRequest()
        request.URLString = "https://api.twitter.com/1.1/search/tweets.json"
        request.method = .get
        request.queryParam = queryParams

        APIClient.shared.defaultAPIAdapter.request(request, successCallback: successCallback, errorCallback: errorCallback)
    }
    
    public class func search(queryString: String,
                             successCallback: @escaping ((_ response: WebAPIResponse) -> Void),
                             errorCallback: @escaping ((_ error: Error) -> Void)) {
        
        let request = WebAPIRequest()
        request.URLString = "https://api.twitter.com/1.1/search/tweets.json\(queryString)"
        request.method = .get
        
        APIClient.shared.defaultAPIAdapter.request(request, successCallback: successCallback, errorCallback: errorCallback)
    }
}
