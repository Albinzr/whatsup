//
//  ImageService.swift
//  Services
//
//  Created by Ankur Kesharwani on 05/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class ImageService {

    public class func fetchImage(fromURLString URLString: String,
                                 successCallback: @escaping ((_ response: WebAPIResponse) -> Void),
                                 errorCallback: @escaping ((_ error: Error) -> Void)) {
        let request = WebAPIRequest.init()
        request.URLString = URLString
        request.method = .get
        request.responseSerializer = WebAPIResponseImageSerializer.self
        
        APIClient.shared.imageAPIAdapter.request(request, successCallback: successCallback, errorCallback: errorCallback)
    }
}
