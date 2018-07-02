//
//  TwitterAuthUI.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/30/2017.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import Theme
import Logic

class TwitterAuthViewController: UIViewController, TwitterAuthUI {

    // MARK: Static/Class Methods

    static func newInstance() -> TwitterAuthUI! {
        return TwitterAuthViewController.init(nibName: "TwitterAuthViewController", bundle: nil)
    }

    // MARK: IBOutlets

    @IBOutlet var vLoaderView: UIView!
    @IBOutlet var vAuthFailView: UIView!
    
    @IBOutlet var bRetryButton: UIButton!
    
    @IBOutlet var ivBigCloudImageView: UIImageView!
    @IBOutlet var ivSmallCloudImageView: UIImageView!
    @IBOutlet var ivSunImageView: UIImageView!
    @IBOutlet var ivBaloonImageView: UIImageView!
    @IBOutlet var lLogoLabel: UILabel!
    
    @IBOutlet var lc_topSpace_ivSunImageView_superView: NSLayoutConstraint!
    @IBOutlet var lc_leadingSpace_ivBigCloudImageView_superView: NSLayoutConstraint!
    @IBOutlet var lc_trailingSpace_ivSmallCloudImageView_superView: NSLayoutConstraint!
    @IBOutlet var lc_center_ivBaloonImageView_superView: NSLayoutConstraint!
    @IBOutlet var lc_topSpace_ivBaloonImageView_superView: NSLayoutConstraint!
    
    // MARK: Properties

    var manager: TwitterAuthManager!

    // MARK: Constants
    
    let consumerKey: String? = Environment.configuration(.consumerKey)
    let secretKey: String? = Environment.configuration(.secretKey)
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLogoAnimation()
        setupAppearance()
    }
    
    // MARK: Public Methods

    func dismissUI() {
        // TODO: Provide own implementation
    }

    // MARK: Open Access Methods

    // MARK: Private Methods
    
    private func setupAppearance() {
        hideLoader()
        hideAuthFailedView()
    }
    
    private func authenticate() {
        manager.authenticate(consumerKey: consumerKey!, secretKey: secretKey!)
    }
    
    private func startLogoAnimation() {
        ivBaloonImageView.alpha = 0.0
        ivSunImageView.alpha = 0.0
        ivSmallCloudImageView.alpha = 0.0
        ivBigCloudImageView.alpha = 0.0
        lc_leadingSpace_ivBigCloudImageView_superView.priority = UILayoutPriority(rawValue: 250)
        lc_topSpace_ivSunImageView_superView.priority = UILayoutPriority(rawValue: 250)
        lc_trailingSpace_ivSmallCloudImageView_superView.priority = UILayoutPriority(rawValue: 250)
        lc_center_ivBaloonImageView_superView.priority = UILayoutPriority(rawValue: 250)
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.ivBaloonImageView.alpha = 1
            self.ivSunImageView.alpha = 1
            self.ivSmallCloudImageView.alpha = 1
            self.ivBigCloudImageView.alpha = 1
        }) { (completed) in
            UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
                self.lLogoLabel.alpha = 0.0
            }, completion: { (completed) in
                self.lLogoLabel.removeFromSuperview()
                
                self.didEndLogoAnimayion()
            })
        }
    }
    
    private func didEndLogoAnimayion() {
        showLoader()
        authenticate()
    }
    
    private func handleAuthFailed() {
        lc_topSpace_ivBaloonImageView_superView.constant = self.view.frame.size.height
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            self.showAuthFailedView()
        }
    }
    
    private func showLoader() {
        vLoaderView.isHidden = false
    }
    
    private func hideLoader() {
        vLoaderView.isHidden = true
    }
    
    private func showAuthFailedView() {
        vAuthFailView.isHidden = false
    }
    
    private func hideAuthFailedView() {
        vAuthFailView.isHidden = true
    }
    
    // MARK: IBActions
    
    @IBAction func bActionRetryButton() {
        self.hideAuthFailedView()
        self.showLoader()
        lc_topSpace_ivBaloonImageView_superView.constant = 100
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            
            self.authenticate()
        }
    }
    
    // MARK: TwitterAuthManagerDelegate
    
    func authSuccessfull(manager: TwitterAuthManager) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.goInside()
    }
    
    func twitterAuthManager(_ manager: TwitterAuthManager, authFailedWithError error: Error?) {
        hideLoader()
        handleAuthFailed()
    }
}
