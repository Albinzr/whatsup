//
//  TweetListNoDataEmptyView.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

protocol TweetListNoDataEmptyViewDelegate: class {
    func didTouchUpInsidePrimaryButton(emptyView: TweetListNoDataEmptyView)
}

class TweetListNoDataEmptyView: UIView {
    
    // MARK: Static/Class Methods
    
    class func newInstance() -> TweetListNoDataEmptyView {
        let view = Bundle.main.loadNibNamed("TweetListNoDataEmptyView",
                                            owner: nil, options: nil)?.first as! TweetListNoDataEmptyView
        
        return view
    }
    
    // MARK: IBOutlets
    
    @IBOutlet var ivImageView: UIImageView!
    @IBOutlet var lTitleLable: UILabel!
    @IBOutlet var lSubtitleLabel: UILabel!
    @IBOutlet var bPrimaryButton: UIButton!
    
    // MARK: Properties
    
    weak var delegate: TweetListNoDataEmptyViewDelegate?
    
    // MARK: Constants
    
    // MARK: Lifecycle Methods
    
    // MARK: Public Methods
    
    func showPrimaryButton() {
        bPrimaryButton.isHidden = false
    }
    
    func hidePrimaryButton() {
        bPrimaryButton.isHidden = true
    }
    
    func set(title: String, subTitle: String, buttonTitle: String?) {
        lTitleLable.text = title
        lSubtitleLabel.text = subTitle
        
        if buttonTitle == nil {
            hidePrimaryButton()
        }
        
        showPrimaryButton()
        bPrimaryButton.setTitle(buttonTitle, for: .normal)
    }
    
    // MARK: Open Access Methods
    
    // MARK: Private Methods
    
    // MARK: IBActions
    
    @IBAction func bActionprimaryButton() {
        delegate?.didTouchUpInsidePrimaryButton(emptyView: self)
    }
}
