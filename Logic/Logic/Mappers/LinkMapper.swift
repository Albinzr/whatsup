//
//  LinkMapper.swift
//  Logic
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Services
import PersistenceStore
import CoreData

class LinkMapper {
    class func getLink(from link: Link?, context: NSManagedObjectContext) -> CDLink? {
        guard link?.urlString != nil else {
            return nil
        }
        
        let cdLink = CDLink.instanceFor(urlString: link!.urlString!, context: context)
        
        cdLink.startIndex = Int64(link?.startIndex ?? 0)
        cdLink.length = Int64(link?.length ?? 0)
        
        return cdLink
    }
}

