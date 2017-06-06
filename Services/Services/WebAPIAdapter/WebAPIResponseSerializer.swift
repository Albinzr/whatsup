//
//  WebAPIResponseSerializer.swift
//  Services
//
//  Created by Ankur Kesharwani on 13/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

protocol WebAPIResponseSerializer {
    static func serialize(data: Data) throws -> AnyObject?
}


class WebAPIResponseJSONSerializer: WebAPIResponseSerializer {
    class func serialize(data: Data) throws -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] as AnyObject
        } catch {
            throw WebAPIAdapterError.responseSerializationError(message: error.localizedDescription)
        }
    }
}

class WebAPIResponseImageSerializer: WebAPIResponseSerializer {
    class func serialize(data: Data) throws -> AnyObject? {
        return UIImage.init(data: data)
    }
}
