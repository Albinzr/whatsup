//
//  CDTweetParser.swift
//  Parsers
//
//  Created by Ankur Kesharwani on 03/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import PersistenceStore
import CoreData

public class CDTweetParser: Parser {
    public class func parseTweet(fromJSON JSON: JSON, context: NSManagedObjectContext) -> CDTweet? {
        do {
            if let strID: String = try parse(key: "id_str", from: JSON) {
                let tweet = CDTweet.instanceFor(strID: strID, context: context)
                parse(tweet: tweet, fromJSON: JSON, context: context)
                
                return tweet
            }
        } catch {
            printError(error)
        }
        
        return nil
    }
    
    public class func parse(tweet: CDTweet, fromJSON JSON: JSON, context: NSManagedObjectContext) {
        do {
            tweet.strID = try parse(key: "id_str", from: JSON)
        } catch {
            printError(error)
        }
        
        do {
            tweet.text = try parse(key: "text", from: JSON)
        } catch {
            printError(error)
        }
        
        do {
            tweet.lang = try parse(key: "lang", from: JSON)
        } catch {
            printError(error)
        }
        
        do {
            tweet.likesCount = try parse(key: "favorite_count", from: JSON) ?? 0
        } catch {
            printError(error)
        }
        
        do {
            tweet.retweetCount = try parse(key: "retweet_count", from: JSON) ?? 0
        } catch {
            printError(error)
        }
        
        do {
            tweet.truncated = try parse(key: "truncated", from: JSON) ?? false
        } catch {
            printError(error)
        }
        
        do {
            tweet.copyrighted = try parse(key: "withheld_copyright", from: JSON) ?? false
        } catch {
            printError(error)
        }
        
        do {
            if let userJSON: JSON = try parse(key: "user", from: JSON) {
                let user = CDUserParser.parseUser(fromJSON: userJSON, context: context)
                tweet.user = user
            }
        } catch {
            printError(error)
        }
        
        // Parse any links in the tweet text
        
        guard tweet.text != nil else {
            return
        }
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: tweet.text!, options: [], range: NSRange(location: 0, length: tweet.text!.utf16.count))
        
        for match in matches {
            let link = CDLink.newInstance(context: context)
            link.startIndex = Int64(match.range.location)
            link.length = Int64(match.range.length)
            link.stringURL = (tweet.text! as NSString).substring(with: match.range)
            
            link.tweet = tweet
        }
    }
}
