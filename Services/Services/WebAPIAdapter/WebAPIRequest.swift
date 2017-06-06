//
//  WebAPIRequest.swift
//  Services
//
//  Created by Ankur Kesharwani on 13/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class WebAPIRequest {
    public typealias QueryParam = [String: String]
    public typealias PathParam = [String: String]
    public typealias BodyParam = [String: Any]
    public typealias Headers = [String: String]
    
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    var method: RequestMethod!
    var URLString: String!
    var queryParam: QueryParam?
    var pathParam: PathParam?
    var bodyParam: BodyParam?
    var additionalHeaders: Headers?
    var requestSerializer: WebAPIRequestSerializer.Type!
    var responseSerializer: WebAPIResponseSerializer.Type!
    
    init() {
        requestSerializer = WebAPIRequestJSONSerializer.self
        responseSerializer  = WebAPIResponseJSONSerializer.self
    }
    
    func toURLRequest() throws -> URLRequest? {
        // TODO: Implement this shit.
        
        var URLString = formURLByPlacingPathParams()
        if let QueryString = formQueryString() {
            URLString.append("?\(QueryString)")
        }
        
        let requestURL = URL(string: URLString)
        var request = URLRequest.init(url: requestURL!)
        request.httpMethod = method.rawValue
        
        if let additionalHeaders = self.additionalHeaders {
            for (key, value) in additionalHeaders {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParams = self.bodyParam {
            request.httpBody = try requestSerializer.serialize(request: bodyParams as AnyObject)
        }
        
        return request
    }
    
    private func formQueryString() -> String? {
        guard queryParam != nil else {
            return nil
        }
        
        var queryComponents = [String]()
        for (key, value) in queryParam! {
            queryComponents.append("\(key)=\(value)")
        }
        
        return queryComponents.joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    private func formURLByPlacingPathParams() -> String {
        var thisURLString = self.URLString
        
        guard pathParam != nil else {
            return thisURLString!
        }
        
        for (key, value) in pathParam! {
            thisURLString = thisURLString?.replacingOccurrences(of: ":\(key)", with: value)
        }
        
        return thisURLString!
    }
}
