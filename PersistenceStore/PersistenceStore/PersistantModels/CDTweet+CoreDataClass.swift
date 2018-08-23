//
//  CDTweet+CoreDataClass.swift
//  
//
//  Created by Ankur Kesharwani on 03/06/17.
//
//

import Foundation
import CoreData

@objc(CDTweet)
public class CDTweet: NSManagedObject {

    // MARK: Static methods
    
    public class func instanceFor(strId: String, context: NSManagedObjectContext) -> CDTweet {
        var instance: CDTweet?
        instance = CDTweet.findOne(strId: strId, context: context)
        if instance == nil {
            instance = CDTweet.newInstance(context: context)
            instance?.strId = strId
        }
        
        return instance!
    }
    
    class func newInstance(context: NSManagedObjectContext) -> CDTweet {
        return NSEntityDescription.insertNewObject(forEntityName: "Tweet", into: context) as! CDTweet
    }
    
    class func findOne(strId: String, context: NSManagedObjectContext) -> CDTweet? {
        let request = NSFetchRequest<CDTweet>(entityName: "Tweet")
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
    
    public class func removeAll(fromContext context: NSManagedObjectContext) {
        let request = NSFetchRequest<CDTweet>(entityName: "Tweet")
        do {
            let results = try context.fetch(request)
            for tweet in results {
                remove(tweet: tweet, fromContext: context)
            }
        } catch {
            fatalError("Failed to find Practitioner: \(error)")
        }
    }
    
    public class func remove(tweet: CDTweet, fromContext context: NSManagedObjectContext) {
        context.delete(tweet)
    }
    
    // MARK: Public methods
    
    public func hasLinks() -> Bool {
        return links != nil && links!.count > 0
    }
}
