//
//  UserMapper.swift
//  Logic
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Services
import PersistenceStore
import CoreData

class UserMapper {
    class func getUser(from user: User?, context: NSManagedObjectContext) -> CDUser? {
        guard user?.strId != nil else {
            return nil
        }
        
        let cdUser = CDUser.instanceFor(strId: user!.strId!, context: context)
        
        cdUser.followRequestSent = user?.followRequestSent ?? false
        cdUser.following = user?.following ?? false
        cdUser.followersCount = Int64(user?.followersCount ?? 0)
        cdUser.friendsCount = Int64(user?.friendsCount ?? 0)
        cdUser.name = user?.name
        cdUser.profileImageUrlString = user?.profileImageUrlString
        cdUser.screenName = user?.screenName
        cdUser.tweetsCount = Int64(user?.tweetsCount ?? 0)
        cdUser.verified = user?.verified ?? false

        return cdUser
    }
}
