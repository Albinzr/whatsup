//
//  UserDialogViewController.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 06/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import PersistenceStore

class UserDialogView: UIView, UserDialogUI {
    
    // MARK: Static/Class Methods
    
    static func newInstance() -> UserDialogUI! {
        let view = Bundle.main.loadNibNamed("UserDialogView", owner: nil, options: nil)?.first as! UserDialogUI
        
        return view
    }
    
    // MARK: IBOutlets
    
    @IBOutlet var vDialogView: UIView!
    @IBOutlet var vBackdropView: UIView!
    
    @IBOutlet var ivProfileImageView: UIImageView!
    @IBOutlet var ivVerifiedImageView: UIImageView!
    @IBOutlet var lUsernameLabel: UILabel!
    @IBOutlet var lFullNameLabel: UILabel!
    @IBOutlet var lFollowLabel: UILabel!
    @IBOutlet var lFollowersCountLabel: UILabel!
    @IBOutlet var lFollowingCountLabel: UILabel!
    @IBOutlet var lTweetCountLabel: UILabel!
    
    // MARK: Properties
    
    var user: CDUser!
    
    // MARK: Constants
    
    // MARK: Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupAppearance()
        

        let grBackdropTapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.grActionBackdropTapGestureRecognizer(gestureRecognizer:)))
        vBackdropView.addGestureRecognizer(grBackdropTapGestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUserDetails()
    }
    
    // MARK: Public Methods
    
    func dismissUI() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (completed) in
            self.removeFromSuperview()
        }
    }
    
    // MARK: Open Access Methods
    
    // MARK: Private Methods
    
    private func setupAppearance() {
        vDialogView.layer.cornerRadius = 4.0
        vDialogView.clipsToBounds = true
    }
    
    private func setUserDetails() {
        ImageUtil.setAsyncImage(fromURLString: user?.profileImageUrlString,
                                placeholderImage: UIImage.init(named: "profile_image_placeholder_image"),
                                to: ivProfileImageView,
                                useTag: 0,
                                placeholderFillColor: nil)
        
        if user.verified == true {
            ivVerifiedImageView.isHidden = false
        } else {
            ivVerifiedImageView.isHidden = true
        }
        
        lUsernameLabel.text = "@\(user.screenName ?? "jhon_doe")"
        lFullNameLabel.text = user.name
        
        if user.following == true {
            lFollowLabel.text = "FOLLOWING"
        } else if user.followRequestSent == true {
            lFollowLabel.text = "FOLLOW REQUEST SENT"
        } else {
            lFollowLabel.text = "NOT FOLLOWING"
        }
        
        lFollowersCountLabel.text = String(user.followersCount)
        lFollowingCountLabel.text = String(user.friendsCount)
        lTweetCountLabel.text = String(user.tweetsCount)
    }
    
    // MARK: IBActions
    
    @objc func grActionBackdropTapGestureRecognizer(gestureRecognizer: UITapGestureRecognizer) {
        dismissUI()
    }
}
