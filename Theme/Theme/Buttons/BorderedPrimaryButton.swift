//
//  BorderedPrimaryButton.swift
//  Theme
//
//  Created by Ankur Kesharwani on 03/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

class BorderedPrimaryButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    func setup() {
        setTitleColor(Theme.Color.muddyRed, for: .normal)
        setTitleColor(Theme.Color.muddyRed, for: .selected)
        
        titleLabel?.font = Theme.Font.semibold(size: .regular)
        backgroundColor = Theme.Color.Background.clear
        
        layer.cornerRadius = 2.0
        layer.borderWidth = 1.0
        layer.borderColor = Theme.Color.muddyRed.cgColor
    }
}
