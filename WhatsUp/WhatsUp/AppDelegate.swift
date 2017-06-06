//
//  AppDelegate.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 31/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import Logic
import Services
import Theme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let bearerToken = AuthUtil.getAccessToken() {
            APIClient.shared.setDefaultHeaders(headers: ["Authorization": "Bearer \(bearerToken)"])
            
            goInside()
        } else {
            goToAuthenticationUI()
        }
        
        return true
    }
    
    func goInside() {
        let tweetListViewController:TweetListViewController = TweetListViewController.newInstance() as! TweetListViewController
        tweetListViewController.twitterSearchManager = TwitterSearchManagerDefaultImpl()
        tweetListViewController.twitterSearchManager.delegate = tweetListViewController
        
        
        let navigationCtrl = UINavigationController.init(rootViewController: tweetListViewController)
        
        window?.rootViewController = navigationCtrl
    }
    
    func goToAuthenticationUI() {
        let authViewController:TwitterAuthViewController = TwitterAuthViewController.newInstance() as! TwitterAuthViewController
        authViewController.manager = TwitterAuthManagerDefaultImpl()
        authViewController.manager.delegate = authViewController
        
        window?.rootViewController = authViewController
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

