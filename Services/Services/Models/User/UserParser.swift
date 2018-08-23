//
//  UserParser.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

class UserParser: Parser {
    public class func getUser(from json: JSON) -> User? {
        do {
            if let strId: String = try parse(key: "id_str", from: json) {
                let user = User.init(strId: strId)
                update(user: user, from: json)
                
                return user
            }
        } catch {
            printError(error)
        }
        
        return nil
    }
    
    public class func update(user: User, from json: JSON) {
        do {
            user.strId = try parse(key: "id_str", from: json)
        } catch {
            printError(error)
        }
        
        do {
            user.followersCount = try parse(key: "followers_count", from: json) ?? 0
        } catch {
            printError(error)
        }
        
        do {
            user.friendsCount = try parse(key: "friends_count", from: json) ?? 0
        } catch {
            printError(error)
        }
        
        do {
            user.following = try parse(key: "following", from: json) ?? false
        } catch {
            printError(error)
        }
        
        do {
            user.followRequestSent = try parse(key: "follow_request_sent", from: json) ?? false
        } catch {
            printError(error)
        }
        
        do {
            user.name = try parse(key: "name", from: json)
        } catch {
            printError(error)
        }
        
        do {
            user.screenName = try parse(key: "screen_name", from: json)
        } catch {
            printError(error)
        }
        
        do {
            user.profileImageUrlString = try parse(key: "profile_image_url_https", from: json)
        } catch {
            printError(error)
        }
        
        do {
            user.verified = try parse(key: "verified", from: json) ?? false
        } catch {
            printError(error)
        }
        
        do {
            user.tweetsCount = try parse(key: "statuses_count", from: json) ?? 0
        } catch {
            printError(error)
        }
    }
}
