//
//  ProfileImageView.swift
//  Theme
//
//  Created by Ankur Kesharwani on 05/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

public class ProfileImageView: UIImageView {
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = self.frame.size.width / 2
        layer.borderWidth = 0.5
        layer.borderColor = Theme.Color.Border.native.cgColor
        
        clipsToBounds = true
    }
}
