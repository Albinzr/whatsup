//
//  FilledPrimaryButton.swift
//  Theme
//
//  Created by Ankur Kesharwani on 03/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

class FilledPrimaryButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    func setup() {
        setTitleColor(Theme.Color.white, for: .normal)
        setTitleColor(Theme.Color.white, for: .selected)
        
        titleLabel?.font = Theme.Font.semibold(size: .regular)
        backgroundColor = Theme.Color.muddyRed
        
        layer.cornerRadius = 2.0
    }
}
