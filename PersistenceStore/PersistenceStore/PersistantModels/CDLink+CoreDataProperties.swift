//
//  CDLink+CoreDataProperties.swift
//  
//
//  Created by Ankur Kesharwani on 05/06/17.
//
//

import Foundation
import CoreData


extension CDLink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLink> {
        return NSFetchRequest<CDLink>(entityName: "Links")
    }

    @NSManaged public var stringURL: String?
    @NSManaged public var startIndex: Int64
    @NSManaged public var length: Int64
    @NSManaged public var tweet: CDTweet?

}
