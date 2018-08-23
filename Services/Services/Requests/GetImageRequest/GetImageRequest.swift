//
//  GetImageRequest.swift
//  Services
//
//  Created by Ankur Kesharwani on 23/08/18.
//  Copyright © 2018 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class GetImageRequest {
    public class Response {
        
        /// Will be set if request failed due to some reason.
        public var error: Error?
        
        /// Bearer token returned upon successful authentication.
        public var image: UIImage?
        
        public init(from error: Error?) {
            self.error = error
        }
        
        public init(from response: WebAPIResponse?) {
            if response!.statusCode >= 200 && response!.statusCode < 300 {
                guard let image = response?.response as? UIImage else {
                    return
                }
                
                self.image = image
            } else {
                self.error = Exception.errorFor(code: response?.statusCode)
            }
        }
    }
    
    public init() {
        // Do nothing
    }
    
    public var urlString: String!
    
    public func execute(onComplete: @escaping (Response) -> Void) {
        let request = WebAPIRequest.init()
        request.URLString = urlString
        request.method = .get
        request.responseSerializer = WebAPIResponseImageSerializer.self
        
        APIClient.shared.defaultAPIAdapter.request(request, successCallback: { (response) in
            onComplete(Response.init(from: response))
        }) { (error) in
            onComplete(Response.init(from: error))
        }
    }
}
