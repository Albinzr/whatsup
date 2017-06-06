//
//  WebAPIAdapterError.swift
//  Services
//
//  Created by Ankur Kesharwani on 13/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public enum WebAPIAdapterError: Error {
    case error(message: String)
    case noData(message: String)
    case requestSerializationError(message: String)
    case responseSerializationError(message: String)
}
