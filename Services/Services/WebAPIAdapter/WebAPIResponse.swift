//
//  WebAPIResponse.swift
//  Services
//
//  Created by Ankur Kesharwani on 13/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class WebAPIResponse {
    public let statusCode: Int
    public var response: AnyObject?
    
    init(statusCode: Int, response: AnyObject?) {
        self.statusCode = statusCode
        self.response = response
    }
}
