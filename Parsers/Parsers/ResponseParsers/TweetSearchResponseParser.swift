//
//  TweetSearchResponseParser.swift
//  Parsers
//
//  Created by Ankur Kesharwani on 03/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import PersistenceStore
import CoreData

public class TweetSearchResponseParser: Parser {
    public class func parseTweetSearchResponse(fromResponseJSON JSON: JSON, context: NSManagedObjectContext) -> TRTweetSearchResponse {
        let response = TRTweetSearchResponse()
        
        // Parse Tweets
        do {
            if let statuses: [JSON] = try parse(key: "statuses", from: JSON) {
                response.tweets = [CDTweet]()
                
                for statusJSON in statuses {
                    if let parsedTweet = CDTweetParser.parseTweet(fromJSON: statusJSON, context: context) {
                        response.tweets?.append(parsedTweet)
                    }
                }
            }
        } catch {
            printError(error)
        }
        
        // Parse meta data
        var metaJSON: JSON? = nil
        do {
            metaJSON = try parse(key: "search_metadata", from: JSON)
        } catch {
            printError(error)
        }
        
        guard metaJSON != nil else {
            return response
        }
        
        do {
            response.maxID = try parse(key: "max_id_str", from: metaJSON!)
        } catch{
            printError(error)
        }
        
        do {
            response.sinceID = try parse(key: "since_id_str", from: metaJSON!)
        } catch{
            printError(error)
        }
        
        do {
            response.nextURL = try parse(key: "next_results", from: metaJSON!)
        } catch{
            printError(error)
        }
        
        do {
            response.query = try parse(key: "query", from: metaJSON!)
        } catch{
            printError(error)
        }
        
        return response
    }
}
