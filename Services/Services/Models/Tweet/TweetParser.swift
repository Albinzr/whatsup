//
//  TweetParser.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class TweetParser: Parser {
    public class func getTweet(from json: JSON) -> Tweet? {
        do {
            guard try nil == parse(key: "in_reply_to_status_id", from: json),
                try nil == parse(key: "in_reply_to_user_id", from: json),
                try nil == parse(key: "in_reply_to_screen_name", from: json) else {
                
                    return nil
            }
            
            if let strId: String = try parse(key: "id_str", from: json) {
                let tweet = Tweet.init(strId: strId)
                update(tweet: tweet, from: json)
                
                return tweet
            }
        } catch {
            printError(error)
        }
        
        return nil
    }
    
    public class func update(tweet: Tweet, from json: JSON) {
        do {
            tweet.strId = try parse(key: "id_str", from: json)
        } catch {
            printError(error)
        }
        
        do {
            tweet.text = try parse(key: "text", from: json)
        } catch {
            printError(error)
        }
        
        do {
            tweet.lang = try parse(key: "lang", from: json)
        } catch {
            printError(error)
        }
        
        do {
            tweet.likesCount = try parse(key: "favorite_count", from: json) ?? 0
        } catch {
            printError(error)
        }
        
        do {
            tweet.retweetCount = try parse(key: "retweet_count", from: json) ?? 0
        } catch {
            printError(error)
        }
        
        do {
            tweet.truncated = try parse(key: "truncated", from: json) ?? false
        } catch {
            printError(error)
        }
        
        do {
            tweet.copyrighted = try parse(key: "withheld_copyright", from: json) ?? false
        } catch {
            printError(error)
        }
        
        do {
            if let userJson: JSON = try parse(key: "user", from: json) {
                let user = UserParser.getUser(from: userJson)
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
        
        if matches.count > 0 {
            tweet.links = [Link]()
        }
        
        for match in matches {
            let link = Link()
            link.startIndex = Int(match.range.location)
            link.length = Int(match.range.length)
            link.urlString = (tweet.text! as NSString).substring(with: match.range)
            
            tweet.links?.append(link)
        }
    }
}
