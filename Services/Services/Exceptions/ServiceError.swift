//
//  Error.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public enum ServiceError: Error {
    case connectionError
    case requestSerializationError
    case responseSerializationError
    case unknown
    
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case requestTimeout
    case serverError
    
    static func errorFor(httpStatusCode: Int?) -> ServiceError {
        if httpStatusCode == nil {
            return .unknown
        }
        
        switch httpStatusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 408:
            return .requestTimeout
        case 500:
            return .serverError
        default:
            return .unknown
        }
    }
    
    static func errorFor(_ error: Error?) -> ServiceError {
        guard let apiAdapterError = error as? WebAPIAdapterError else {
            return .unknown
        }
    
        switch apiAdapterError {
        case .error:
            return .connectionError
        case .requestSerializationError:
            return .requestSerializationError
        case .responseSerializationError:
            return .responseSerializationError
        default:
            return .unknown
        }
    }
}
