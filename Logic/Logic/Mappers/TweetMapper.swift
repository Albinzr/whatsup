//
//  TweetMapper.swift
//  Logic
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Services
import PersistenceStore
import CoreData

class TweetMapper {
    class func getTweet(from tweet: Tweet?, context: NSManagedObjectContext) -> CDTweet? {
        guard tweet?.strId != nil else {
            return nil
        }
        
        let cdTweet = CDTweet.instanceFor(strId: tweet!.strId!, context: context)
        
        cdTweet.copyrighted = tweet?.copyrighted ?? false
        cdTweet.lang = tweet?.lang
        cdTweet.likesCount = Int64(tweet?.likesCount ?? 0)
        cdTweet.retweetCount = Int64(tweet?.retweetCount ?? 0)
        cdTweet.source = tweet?.source
        cdTweet.text = tweet?.text
        cdTweet.truncated = tweet?.truncated ?? false
        cdTweet.user = UserMapper.getUser(from: tweet?.user, context: context)
        
        if let links = tweet?.links {
            for link in links {
                if let link = LinkMapper.getLink(from: link, context: context) {
                    cdTweet.addToLinks(link)
                }
            }
        }
    
        return cdTweet
    }
}
