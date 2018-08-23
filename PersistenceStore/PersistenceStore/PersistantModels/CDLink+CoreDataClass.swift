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
    
    // MARK: Static methods
    
    public class func instanceFor(urlString: String, context: NSManagedObjectContext) -> CDLink {
        var instance: CDLink?
        instance = CDLink.findOne(urlString: urlString, context: context)
        if instance == nil {
            instance = CDLink.newInstance(context: context)
            instance?.urlString = urlString
        }
        
        return instance!
    }
    
    public class func newInstance(context: NSManagedObjectContext) -> CDLink {
        return NSEntityDescription.insertNewObject(forEntityName: "Link", into: context) as! CDLink
    }
    
    class func findOne(urlString: String, context: NSManagedObjectContext) -> CDLink? {
        let request = NSFetchRequest<CDLink>(entityName: "Link")
        request.predicate = NSPredicate.init(format: "urlString=%@", urlString)
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
    
    public class func removeAll(fromContext context: NSManagedObjectContext) {
        let request = NSFetchRequest<CDLink>(entityName: "Link")
        do {
            let results = try context.fetch(request)
            for tweet in results {
                remove(tweet: tweet, fromContext: context)
            }
        } catch {
            fatalError("Failed to find Practitioner: \(error)")
        }
    }
    
    public class func remove(tweet: CDLink, fromContext context: NSManagedObjectContext) {
        context.delete(tweet)
    }
    
}
