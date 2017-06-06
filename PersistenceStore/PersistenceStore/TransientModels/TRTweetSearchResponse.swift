//
//  TweetSearchResponse.swift
//  PersistenceStore
//
//  Created by Ankur Kesharwani on 03/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class TRTweetSearchResponse {
    public var tweets: [CDTweet]?
    public var nextURL: String?
    public var maxID: String?
    public var sinceID: String?
    public var query: String?
    
    public init() {}
}
