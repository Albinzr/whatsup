//
//  CDUser+CoreDataClass.swift
//  
//
//  Created by Ankur Kesharwani on 03/06/17.
//
//

import Foundation
import CoreData

@objc(CDUser)
public class CDUser: NSManagedObject {

    // MARK: Static methods
    
    public class func instanceFor(strId: String, context: NSManagedObjectContext) -> CDUser {
        var instance: CDUser?
        instance = CDUser.findOne(strId: strId, context: context)
        if instance == nil {
            instance = CDUser.newInstance(context: context)
            instance?.strId = strId
        }
        
        return instance!
    }
    
    class func newInstance(context: NSManagedObjectContext) -> CDUser {
        return NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! CDUser
    }
    
    class func findOne(strId: String, context: NSManagedObjectContext) -> CDUser? {
        let request = NSFetchRequest<CDUser>(entityName: "User")
        request.predicate = NSPredicate.init(format: "strId=%@", strId)
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                return results[0]
            }
        } catch {
            fatalError("Failed to find Practitioner: \(error)")
        }
        return nil
    }
    
    // MARK: Public methods

}
