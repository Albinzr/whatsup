//
//  SearchTweetRequestResponseParser.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

class SearchTweetRequestResponseParser: Parser {

    public class func update(response: SearchTweetsRequest.Response, from json: JSON) {
        // Parse Tweets
        do {
            if let statuses: [JSON] = try parse(key: "statuses", from: json) {
                response.tweets = [Tweet]()
                
                for statusJson in statuses {
                    if let parsedTweet = TweetParser.getTweet(from: statusJson) {
                        response.tweets?.append(parsedTweet)
                    }
                }
            }
        } catch {
            printError(error)
        }
        
        // Parse meta data
        var metaJson: JSON? = nil
        do {
            metaJson = try parse(key: "search_metadata", from: json)
        } catch {
            printError(error)
        }
        
        guard metaJson != nil else {
            return
        }
        
        do {
            response.maxID = try parse(key: "max_id_str", from: metaJson!)
        } catch{
            printError(error)
        }
        
        do {
            response.sinceID = try parse(key: "since_id_str", from: metaJson!)
        } catch{
            printError(error)
        }
        
        do {
            response.nextURL = try parse(key: "next_results", from: metaJson!)
        } catch{
            printError(error)
        }
        
        do {
            response.query = try parse(key: "query", from: metaJson!)
        } catch{
            printError(error)
        }
    }
}
