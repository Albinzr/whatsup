//
//  ServicesTests.swift
//  ServicesTests
//
//  Created by Ankur Kesharwani on 06/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import XCTest
@testable import Services

class ServicesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccessfullTwitterAuth() {
        
        // Define stuff
        let loginResponseExpectation = XCTestExpectation.init()
        let waiter = XCTWaiter.init()
        
        // Make API call
        AuthService.authenticate(basicToken: "Basic empnRzRNRklxWlg1QzNiNnpvZ0p3Vk9QQzpzWXYybGdEam5tUWtFRmxqNjk4cXBJM3RjbnJDTWJTbW5jZnR0bFFlbmxqWGlQakY0Yw==", successCallback: { (response) in
            if response.statusCode == 200 {
                let responseJSON = response.response as! [String: String]
                if let bearerToken = responseJSON["access_token"] {
                    APIClient.shared.setDefaultHeaders(headers: ["Authorization": "Bearer \(bearerToken)"])
                    
                    loginResponseExpectation.fulfill()
                } else {
                    XCTFail("No access token provided")
                    
                    loginResponseExpectation.fulfill()
                }
            } else  {
                XCTFail("Status \(response.statusCode)")
                
                loginResponseExpectation.fulfill()
            }
        }) { (error) in
            XCTFail(error.localizedDescription)
            
            loginResponseExpectation.fulfill()
        }
        
        // Wait till completion and evaluate result
        let result = waiter.wait(for: [loginResponseExpectation], timeout: 60)
        if result == .timedOut {
            XCTFail("No response from server")
        }
    }
    
    func testSuccessfullTwitterSearch() {
        
        // Define stuff
        let searchResponseExpectation = XCTestExpectation.init()
        let waiter = XCTWaiter.init()
        
        // Make API call
        let queryParams = [
            "q": "Trump",
            "result_type": "recent",
            "count": "20",
            "lang": "en"
        ]
        
        SearchService.search(queryParams: queryParams, successCallback: { (response) in
            if response.statusCode == 200 {
                searchResponseExpectation.fulfill()
            } else  {
                XCTFail("Status \(response.statusCode)")
                
                searchResponseExpectation.fulfill()
            }
        }) { (error) in
            XCTFail(error.localizedDescription)
            
            searchResponseExpectation.fulfill()
        }
        
        // Wait till completion and evaluate result
        let result = waiter.wait(for: [searchResponseExpectation], timeout: 60)
        if result == .timedOut {
            XCTFail("No response from server")
        }
    }
}
