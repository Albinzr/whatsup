//
//  Link.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class Link: Equatable {
    public var urlString: String?
    public var startIndex: Int?
    public var length: Int?
    
    public init(urlString: String? = nil) {
        self.urlString = urlString
    }
    
    public static func == (lhs: Link, rhs: Link) -> Bool {
        return lhs.urlString == rhs.urlString
    }
}
