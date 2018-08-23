//
//  TweetTableViewCell.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import PersistenceStore
import Theme


protocol TweetTableViewCellDelegate: class {
    func tweetTableViewCell(_ cell: TweetTableViewCell, didSelectUser user: CDUser)
}

class TweetTableViewCell: UITableViewCell {

    // MARK: Static/Class Methods
    
    static func registerCellForTableView(tableView: UITableView) {
        let nib = UINib.init(nibName: "TweetTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: kIdentifier)
    }
    
    // MARK: IBOutlets
    
    @IBOutlet var ivProfileImageView: UIImageView!
    @IBOutlet var ivVerifiedImageView: UIImageView!
    @IBOutlet var lUsernameLabel: UILabel!
    @IBOutlet var lFullName: UILabel!
    @IBOutlet var lText: UILabel!
    @IBOutlet var lLikeCountLabel: UILabel!
    @IBOutlet var lRetweetCountLable: UILabel!
    @IBOutlet var bUserInfoButton: UIButton!
    
    // MARK: Properties
    
    var tweet: CDTweet!
    weak var delegate: TweetTableViewCellDelegate?
    
    // MARK: Constants
    
    static let kIdentifier = "TweetTableViewCell"
    
    // MARK: Lifecycle Methods
    
    // MARK: Public Methods
    
    func configureWithObject(object: AnyObject, forIndexPath indexPath: IndexPath) {
        tweet = object as? CDTweet
        
        if tweet?.user?.verified == true {
            ivVerifiedImageView.isHidden = false
        } else {
            ivVerifiedImageView.isHidden = true
        }
        
        lUsernameLabel.text = "@\(tweet.user?.screenName ?? "jhon_doe")"
        lFullName.text = tweet.user?.name
        lLikeCountLabel.text = String(tweet.likesCount)
        lRetweetCountLable.text = String(tweet.retweetCount)
        
        
        if let links = tweet.links?.allObjects as? [CDLink] {
             let attributedText = NSMutableAttributedString.init(string: tweet!.text!)
            
            for link in links {
                let range = NSRange.init(location: Int(link.startIndex), length: Int(link.length))
                attributedText.addAttributes([NSAttributedStringKey.foregroundColor : Theme.Color.skyBlue,
                                              NSAttributedStringKey.font: Theme.Font.semibold(size: .large)], range: range)
            }
            
            lText.attributedText = attributedText
        } else {
            lText.text = tweet.text
        }
        
        ImageUtil.setAsyncImage(fromURLString: tweet.user?.profileImageUrlString,
                                placeholderImage: UIImage.init(named: "profile_image_placeholder_image"),
                                to: ivProfileImageView,
                                useTag: indexPath.row,
                                placeholderFillColor: nil)
    }
    
    // MARK: Open Access Methods
    
    // MARK: Private Methods
    
    // MARK: IBActions
    
    @IBAction func bActionUserInfoButton() {
        if let user = tweet.user {
            delegate?.tweetTableViewCell(self, didSelectUser: user)
        }
    }
    
}
