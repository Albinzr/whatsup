//
//  CDTweet+CoreDataProperties.swift
//  
//
//  Created by Ankur Kesharwani on 05/06/17.
//
//

import Foundation
import CoreData


extension CDTweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTweet> {
        return NSFetchRequest<CDTweet>(entityName: "Tweet")
    }

    @NSManaged public var copyrighted: Bool
    @NSManaged public var lang: String?
    @NSManaged public var likesCount: Int64
    @NSManaged public var retweetCount: Int64
    @NSManaged public var source: String?
    @NSManaged public var strId: String?
    @NSManaged public var text: String?
    @NSManaged public var truncated: Bool
    @NSManaged public var user: CDUser?
    @NSManaged public var links: NSSet?

}

// MARK: Generated accessors for links
extension CDTweet {

    @objc(addLinksObject:)
    @NSManaged public func addToLinks(_ value: CDLink)

    @objc(removeLinksObject:)
    @NSManaged public func removeFromLinks(_ value: CDLink)

    @objc(addLinks:)
    @NSManaged public func addToLinks(_ values: NSSet)

    @objc(removeLinks:)
    @NSManaged public func removeFromLinks(_ values: NSSet)

}
