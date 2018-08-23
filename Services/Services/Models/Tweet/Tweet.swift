//
//  Tweet.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class Tweet: Equatable {
    public var copyrighted: Bool?
    public var lang: String?
    public var likesCount: Int?
    public var retweetCount: Int?
    public var source: String?
    public var strId: String?
    public var text: String?
    public var truncated: Bool?
    public var user: User?
    public var links: [Link]?
    
    public init(strId: String? = nil) {
        self.strId = strId
    }
    
    public static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        return lhs.strId == rhs.strId
    }
}
