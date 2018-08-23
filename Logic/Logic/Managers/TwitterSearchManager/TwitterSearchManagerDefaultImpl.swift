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
import CoreData

public class TwitterSearchManagerDefaultImpl: TwitterSearchManager {
    weak public var delegate: TwitterSearchManagerDelegate?

    public var context: NSManagedObjectContext!
    
    var childContext: NSManagedObjectContext!
    var tweets: [Tweet]?
    var nextURL: String?
    var maxID: String?
    var sinceID: String?
    var query: String?
    
    public init() {
        context = CDStack.getSharedMOC()
        childContext = CDStack.newChildOfSharedMOC()
    }
    
    public func fetchTweetsForSearchString(_ string: String) {
        let searchTweetsRequest = SearchTweetsRequest()
        searchTweetsRequest.count = 20
        searchTweetsRequest.lang = .en
        searchTweetsRequest.query = string
        searchTweetsRequest.execute { (response) in
            if response.error != nil {
                if let serviceError = response.error as? ServiceError {
                    self.delegate?.twitterSearchManager(self,
                                                        searchFailedWithError: serviceError)
                    
                    return
                }
                
                self.delegate?.twitterSearchManager(self,
                                                    searchFailedWithError: TwitterSearchManagerError.statusNotOk)
                
                return
            }
            
            if response.tweets != nil {
                self.delegate?.twitterSearchManager(self,
                                                    searchFailedWithError: TwitterSearchManagerError.nilResponse)
                
                return
            }
            
            self.nextURL = response.nextURL
            self.maxID = response.maxID
            self.sinceID = response.sinceID
            self.query = response.query
        
            var tweets = [CDTweet]()
            for tweet in response.tweets! {
                if let cdTweet = TweetMapper.getTweet(from: tweet, context: self.childContext) {
                    tweets.append(cdTweet)
                }
            }
            
            CDStack.saveAsyncMOC(self.childContext, cascadeSave: true)
            self.delegate?.twitterSearchManager(self, fetchedTweets: tweets)
        }
    }
    
    public func fetchNextTweetsSet() {
        guard nextURL != nil else {
            return
        }
        
        let searchTweetsRequest = SearchTweetsRequest()
        searchTweetsRequest.nextUrl = nextURL
        searchTweetsRequest.execute { (response) in
            if response.error != nil {
                if let serviceError = response.error as? ServiceError {
                    self.delegate?.twitterSearchManager(self,
                                                        searchFailedWithError: serviceError)
                    
                    return
                }
                
                self.delegate?.twitterSearchManager(self,
                                                    searchFailedWithError: TwitterSearchManagerError.statusNotOk)
                
                return
            }
            
            if response.tweets != nil {
                self.delegate?.twitterSearchManager(self,
                                                    searchFailedWithError: TwitterSearchManagerError.nilResponse)
                
                return
            }
            
            self.nextURL = response.nextURL
            self.maxID = response.maxID
            self.sinceID = response.sinceID
            self.query = response.query
            
            var tweets = [CDTweet]()
            for tweet in response.tweets! {
                if let cdTweet = TweetMapper.getTweet(from: tweet, context: self.childContext) {
                    tweets.append(cdTweet)
                }
            }
            
            CDStack.saveAsyncMOC(self.childContext, cascadeSave: true)
            self.delegate?.twitterSearchManager(self, fetchedTweets: tweets)
        }
    }
    
    public func hasNext() -> Bool {
        return nextURL != nil
    }
}

