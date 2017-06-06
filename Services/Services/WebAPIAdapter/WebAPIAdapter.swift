//
//  WebAPIRequestAdapter.swift
//  Services
//
//  Created by Ankur Kesharwani on 13/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation

public class WebAPIAdapter {
    let sessionConfig: URLSessionConfiguration!
    let session: URLSession!
    
    init(sessionConfiguration: URLSessionConfiguration?) {
        var config: URLSessionConfiguration?
        if sessionConfiguration == nil {
            let defaultConfig = URLSessionConfiguration.default
            defaultConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
            defaultConfig.urlCache = nil
            defaultConfig.timeoutIntervalForRequest = 30
        
            config = defaultConfig
        } else {
            config = sessionConfiguration
        }
        
        sessionConfig = config!
        session = URLSession.init(configuration: sessionConfig)
    }
    
    func request(_ request: WebAPIRequest,
                 successCallback: @escaping ((_ response: WebAPIResponse) -> Void),
                 errorCallback: @escaping ((_ error: Error) -> Void)) {
        do {
            let thiURLRequest = try request.toURLRequest()
            self.debugPrint(request: thiURLRequest!)
            
            let task = self.session.dataTask(with: thiURLRequest!, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        errorCallback(WebAPIAdapterError.error(message: error!.localizedDescription))
                    }
                    
                    return
                }
                
                if response == nil {
                    DispatchQueue.main.async {
                        errorCallback(WebAPIAdapterError.noData(message: "Got no response"))
                    }
                    
                    return
                }
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                let thisAPIResponse = WebAPIResponse.init(statusCode: statusCode, response: nil)
                if data != nil {
                    do {
                        thisAPIResponse.response = try request.responseSerializer.serialize(data: data!)
                    } catch {
                        DispatchQueue.main.async {
                            errorCallback(WebAPIAdapterError.responseSerializationError(message: error.localizedDescription))
                        }
                        
                        return
                    }
                }
                
                DispatchQueue.main.async {
                    
                    // TODO: Remove this in production.
                    self.debugPrint(response: thisAPIResponse)
                    
                    successCallback(thisAPIResponse)
                }
            })
            
            task.resume()
        } catch {
            DispatchQueue.main.async {
                errorCallback(error)
            }
        }
    }
    
    private func debugPrint(request: URLRequest) {
        print("\n\((request.httpMethod ?? "METHOD NOT PROVIDED")!) \(request.debugDescription)")
        print("\nAdditional Headers:")
        print(request.allHTTPHeaderFields ?? "NOT PROVIDED")
        print("\nSession Headers:")
        print(session.configuration.httpAdditionalHeaders as? WebAPIRequest.Headers ?? "NOT PROVIDED")
        
        if let body = request.httpBody {
            print("\nBody:")
            print(String.init(data: body, encoding: .utf8)!)
        }
    }
    
    private func debugPrint(response: WebAPIResponse) {
        print("\nResponse Code: \(response.statusCode)")
        if let responseBody = response.response {
            
            guard responseBody is [String: Any] else {
                return
            }
            
            do {
                let responseData = try JSONSerialization.data(withJSONObject: responseBody, options: .prettyPrinted)
                print("Response Body:")
                print(String.init(data: responseData, encoding: .utf8)!)}
            catch {
                // Do nothing.
            }
        }
    }
}
