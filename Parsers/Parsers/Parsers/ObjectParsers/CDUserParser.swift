//
//  CDUserParser.swift
//  Parsers
//
//  Created by Ankur Kesharwani on 03/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import PersistenceStore
import CoreData

public class CDUserParser: Parser {
    public class func parseUser(fromJSON JSON: JSON, context: NSManagedObjectContext) -> CDUser? {
        do {
            if let strID: String = try parse(key: "id_str", from: JSON) {
                let user = CDUser.instanceFor(strID: strID, context: context)
                parse(user: user, fromJSON: JSON, context: context)
                
                return user
            }
        } catch {
            printError(error)
        }
        
        return nil
    }
    
    public class func parse(user: CDUser, fromJSON JSON: JSON, context: NSManagedObjectContext) {
        do {
            user.strID = try parse(key: "id_str", from: JSON)
        } catch {
            printError(error)
        }
        
        do {
            user.followersCount = try parse(key: "followers_count", from: JSON) ?? 0
        } catch {
            printError(error)
        }
        
        do {
            user.friendsCount = try parse(key: "friends_count", from: JSON) ?? 0
        } catch {
            printError(error)
        }
        
        do {
            user.following = try parse(key: "following", from: JSON) ?? false
        } catch {
            printError(error)
        }
        
        do {
            user.followRequestSent = try parse(key: "follow_request_sent", from: JSON) ?? false
        } catch {
            printError(error)
        }
        
        do {
            user.name = try parse(key: "name", from: JSON)
        } catch {
            printError(error)
        }
        
        do {
            user.screenName = try parse(key: "screen_name", from: JSON)
        } catch {
            printError(error)
        }
        
        do {
            user.profileImageURLString = try parse(key: "profile_image_url_https", from: JSON)
        } catch {
            printError(error)
        }
        
        do {
            user.verified = try parse(key: "verified", from: JSON) ?? false
        } catch {
            printError(error)
        }
        
        do {
            user.tweetsCount = try parse(key: "statuses_count", from: JSON) ?? 0
        } catch {
            printError(error)
        }
    }
}
