//
//  LogicTests.swift
//  LogicTests
//
//  Created by Ankur Kesharwani on 06/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import XCTest
import Services
import PersistenceStore
import CoreData
@testable import Logic

class LogicTests: XCTestCase, TwitterAuthManagerDelegate, TwitterSearchManagerDelegate {
    var authTestCompleteExpectation: XCTestExpectation!
    var searchTestCompleteExpectation: XCTestExpectation!
    
    var authManager: TwitterAuthManager!
    var searchManager: TwitterSearchManager!
    
    override func setUp() {
        super.setUp()
        
        authManager = TwitterAuthManagerDefaultImpl()
        authManager.delegate = self
        
        searchManager = TwitterSearchManagerDefaultImpl()
        searchManager.delegate = self
    }
    
    override func tearDown() {
        authManager.delegate = nil
        searchManager.delegate = nil
        
        super.tearDown()
    }
    
    func testAuthManager() {
        authTestCompleteExpectation = XCTestExpectation()
        
        authManager.authenticate(consumerKey: "zjgG4MFIqZX5C3b6zogJwVOPC",
                                 secretKey: "sYv2lgDjnmQkEFlj698qpI3tcnrCMbSmncfttlQenljXiPjF4c")
        
        let waiterResult = XCTWaiter.init().wait(for: [authTestCompleteExpectation], timeout: 60)
        if waiterResult == .timedOut {
            XCTFail("Time out")
        }
    }
    
    func authSuccessfull(manager: TwitterAuthManager) {
        if let accessToken = AuthUtil.getAccessToken() {
            APIClient.shared.setDefaultHeaders(headers: ["Authorization": "Bearer \(accessToken)"])
        } else {
            XCTFail("Access token not set")
        }
        
        authTestCompleteExpectation.fulfill()
    }
    
    func twitterAuthManager(_ manager: TwitterAuthManager, authFailedWithError error: Error?) {
        print(error?.localizedDescription ?? "No error provided")
        
        XCTFail("Login failed")
        
        authTestCompleteExpectation.fulfill()
    }
    
    func testSearchManager() {
        searchTestCompleteExpectation = XCTestExpectation()
        
        searchManager.fetchTweetsForSearchString("India")
        
        let waiterResult = XCTWaiter.init().wait(for: [searchTestCompleteExpectation], timeout: 60)
        if waiterResult == .timedOut {
            XCTFail("Time out")
        }
    }
    
    func twitterSearchManager(_ manager: TwitterSearchManager, fetchedTweets tweets: [CDTweet]?) {
        if tweets?.count == 0 {
            XCTFail("No tweets retruned")
            searchTestCompleteExpectation.fulfill()
            
            return
        }
        
        searchTestCompleteExpectation.fulfill()
    }
    
    func twitterSearchManager(_ manager: TwitterSearchManager, searchFailedWithError error: Error?) {
        print(error?.localizedDescription ?? "No error provided")
        
        XCTFail("Search failed")
        
        searchTestCompleteExpectation.fulfill()
    }
}
