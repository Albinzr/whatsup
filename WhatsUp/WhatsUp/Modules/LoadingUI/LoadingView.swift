//
//  LoadingView.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import Theme

class LoadingView: UIView, LoadingUI {
    
    // MARK: Static/Class Methods
    
    internal class func newInstance() -> LoadingUI {
        let view = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)?.first as! LoadingView
        return view
    }
    
    // MARK: IBOutlets
    
    @IBOutlet var aiActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var lTitleLable: UILabel!
    @IBOutlet var vBackdropView: UIView!
    
    // MARK: Properties
    
    // MARK: Constants
    
    static let sharedLoadingView = LoadingView.newInstance()
    var count = 0
    
    // MARK: Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupAppearance()
    }
    
    // MARK: Public Methods
    
    func setAppearance(style: LoadingUIAppearance) {
        if style == .dark {
            aiActivityIndicator.color = UIColor.white
            vBackdropView.backgroundColor = UIColor.black
            vBackdropView.alpha = 0.5
            lTitleLable.textColor = Theme.Color.white
        } else {
            aiActivityIndicator.color = UIColor.gray
            vBackdropView.backgroundColor = UIColor.white
            vBackdropView.alpha = 1.0
            lTitleLable.textColor = UIColor.gray
        }
    }
    
    // MARK: Open Access Methods
    
    // MARK: Private Methods
    
    private func setupAppearance() {
        lTitleLable.font = Theme.Font.semibold(size: .regular)
    }
    
    // MARK: IBActions
}
