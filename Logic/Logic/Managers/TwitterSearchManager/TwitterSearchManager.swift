//
//  TwitterSearchManager.swift
//  Logic
//
//  Created by Ankur Kesharwani on 01/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import PersistenceStore
import CoreData

public enum TwitterSearchManagerError: Error {
    case nilResponse
    case urlEncodeException
    case statusNotOk
}

public protocol TwitterSearchManagerDelegate: class {
    func twitterSearchManager(_ manager: TwitterSearchManager, fetchedTweets tweets: [CDTweet]?)
    func twitterSearchManager(_ manager: TwitterSearchManager, searchFailedWithError error: Error?)
    
    func authenticationExpired(manager: TwitterSearchManager)
}

public protocol TwitterSearchManager: class {
    var delegate: TwitterSearchManagerDelegate? { get set }
    var context: NSManagedObjectContext! { get set }
    
    func fetchTweetsForSearchString(_ string: String)
    func fetchNextTweetsSet()
    func hasNext() -> Bool
}
