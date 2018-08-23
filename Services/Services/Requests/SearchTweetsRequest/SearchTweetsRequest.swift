//
//  SearchTweetsRequest.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class SearchTweetsRequest {
    public class Response {
        
        /// Will be set if request failed due to some reason.
        public var error: Error?

        public var tweets: [Tweet]?
        public var nextURL: String?
        public var maxID: String?
        public var sinceID: String?
        public var query: String?
        
        public init(from error: Error?) {
            self.error = error
        }
        
        public init(from response: WebAPIResponse?) {
            if response!.statusCode >= 200 && response!.statusCode < 300 {
                guard let dict = response?.response as? [String: Any] else {
                    return
                }
                
                SearchTweetRequestResponseParser.update(response: self, from: dict)
            } else {
                self.error = Exception.errorFor(code: response?.statusCode)
            }
        }
    }
    
    public init() {
        // Do nothing
    }
    
    public enum Lang: String {
        case en, hi
    }
    
    public var query: String!
    public var lang: Lang!
    public var count: Int!
    public var nextUrl: String?
    
    public func execute(onComplete: @escaping (Response) -> Void) {
        let request = WebAPIRequest()
        
        if nextUrl == nil {
            request.URLString = "https://api.twitter.com/1.1/search/tweets.json"
            request.method = .get
            request.queryParam = [
                "q": "\(query) -filter:retweets -filter:truncated",
                "result_type": "recent",
                "count": String(count),
                "lang": lang.rawValue
            ]
        } else {
            let request = WebAPIRequest()
            request.URLString = "https://api.twitter.com/1.1/search/tweets.json\(nextUrl!)"
            request.method = .get
        }
        
        APIClient.shared.defaultAPIAdapter.request(request, successCallback: { (response) in
            onComplete(Response.init(from: response))
        }) { (error) in
            onComplete(Response.init(from: error))
        }
    }
}
