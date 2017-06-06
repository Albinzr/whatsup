//
//  TwitterSearchManagerDefaultImpl.swift
//  Logic
//
//  Created by Ankur Kesharwani on 01/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import Services
import PersistenceStore
import Parsers
import CoreData

public class TwitterSearchManagerDefaultImpl: TwitterSearchManager {
    weak public var delegate: TwitterSearchManagerDelegate?

    public var context: NSManagedObjectContext!
    
    var childContext: NSManagedObjectContext!
    var twitterSearchResponse: TRTweetSearchResponse?
    
    public init() {
        context = CDStack.getSharedMOC()
        childContext = CDStack.newChildOfSharedMOC()
    }
    
    public func fetchTweetsForSearchString(_ string: String) {
        let queryParams = [
            "q": "\(string) -filter:retweets -filter:truncated",
            "result_type": "recent",
            "count": "20",
            "lang": "en"
        ]
        
        SearchService.search(queryParams: queryParams, successCallback: { (response) in
            if response.statusCode == 200 {
                if let responseJSON = response.response as? JSON {
                    
                    // Clear all previous tweets
                    CDTweet.removeAll(fromContext: self.context)
                    
                    // Parse new feeds
                    self.twitterSearchResponse = TweetSearchResponseParser.parseTweetSearchResponse(fromResponseJSON: responseJSON,
                                                                                              context: self.childContext)
                    
                    // Save
                    CDStack.saveAsyncMOC(self.childContext, cascadeSave: true)
                    
                    self.delegate?.twitterSearchManager(self, fetchedTweets: self.twitterSearchResponse?.tweets)
                } else {
                    self.delegate?.twitterSearchManager(self, searchFailedWithError: TwitterSearchManagerError.nilResponse)
                }
            } else if response.statusCode == 400 {
                self.delegate?.authenticationExpired(manager: self)
            } else {
                self.delegate?.twitterSearchManager(self, searchFailedWithError: TwitterSearchManagerError.statusNotOk)
            }
        }) { (error) in
            self.delegate?.twitterSearchManager(self, searchFailedWithError: error)
        }
    }
    
    public func fetchNextTweetsSet() {
        guard twitterSearchResponse?.nextURL != nil else {
            return
        }
        
        SearchService.search(queryString: twitterSearchResponse!.nextURL!, successCallback: { (response) in
            if response.statusCode == 200 {
                if let responseJSON = response.response as? JSON {
                    
                    // Parse new feeds
                    self.twitterSearchResponse = TweetSearchResponseParser.parseTweetSearchResponse(fromResponseJSON: responseJSON,
                                                                                               context: self.childContext)
                    
                    // Save
                    CDStack.saveAsyncMOC(self.childContext, cascadeSave: true)
                    
                    self.delegate?.twitterSearchManager(self, fetchedTweets: self.twitterSearchResponse?.tweets)
                } else {
                    self.delegate?.twitterSearchManager(self, searchFailedWithError: TwitterSearchManagerError.nilResponse)
                }
                
            } else if response.statusCode == 400 {
                self.delegate?.authenticationExpired(manager: self)
            } else {
                self.delegate?.twitterSearchManager(self, searchFailedWithError: TwitterSearchManagerError.statusNotOk)
            }
        }) { (error) in
            self.delegate?.twitterSearchManager(self, searchFailedWithError: error)
        }
    }
    
    public func hasNext() -> Bool {
        return twitterSearchResponse?.nextURL != nil
    }
}

