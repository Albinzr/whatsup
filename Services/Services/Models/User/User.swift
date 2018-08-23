//
//  user.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class User: Equatable {
    public var followRequestSent: Bool?
    public var following: Bool?
    public var followersCount: Int?
    public var friendsCount: Int?
    public var strId: String?
    public var name: String?
    public var profileImageURLString: String?
    public var screenName: String?
    public var tweetsCount: Int?
    public var verified: Bool?
    
    public init(strId: String? = nil) {
        self.strId = strId
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.strId == rhs.strId
    }
}
