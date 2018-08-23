//
//  CDUser+CoreDataProperties.swift
//  
//
//  Created by Ankur Kesharwani on 03/06/17.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "User")
    }

    @NSManaged public var followRequestSent: Bool
    @NSManaged public var following: Bool
    @NSManaged public var followersCount: Int64
    @NSManaged public var friendsCount: Int64
    @NSManaged public var strId: String?
    @NSManaged public var name: String?
    @NSManaged public var profileImageUrlString: String?
    @NSManaged public var screenName: String?
    @NSManaged public var tweetsCount: Int64
    @NSManaged public var verified: Bool
    @NSManaged public var tweets: NSSet?

}

// MARK: Generated accessors for tweets
extension CDUser {

    @objc(addTweetsObject:)
    @NSManaged public func addToTweets(_ value: CDTweet)

    @objc(removeTweetsObject:)
    @NSManaged public func removeFromTweets(_ value: CDTweet)

    @objc(addTweets:)
    @NSManaged public func addToTweets(_ values: NSSet)

    @objc(removeTweets:)
    @NSManaged public func removeFromTweets(_ values: NSSet)

}
