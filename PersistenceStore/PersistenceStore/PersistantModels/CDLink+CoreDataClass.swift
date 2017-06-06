//
//  CDLink+CoreDataClass.swift
//  
//
//  Created by Ankur Kesharwani on 05/06/17.
//
//

import Foundation
import CoreData

@objc(CDLink)
public class CDLink: NSManagedObject {

    public class func newInstance(context: NSManagedObjectContext) -> CDLink {
        return NSEntityDescription.insertNewObject(forEntityName: "Link", into: context) as! CDLink
    }
    
}
