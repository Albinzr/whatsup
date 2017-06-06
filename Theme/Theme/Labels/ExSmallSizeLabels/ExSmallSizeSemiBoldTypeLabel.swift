//
//  ExSmallSizeSemiBoldTypeLabel.swift
//  Theme
//
//  Created by Ankur Kesharwani on 23/02/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

public class ExSmallSizeSemiBoldTypeLabel: UILabel {

    @IBInspectable public var themeTextColor: String? {
        didSet {
            self.textColor = Theme.keyToColorMap[themeTextColor!] ?? self.textColor
        }
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    public func setup() {
        if themeTextColor == nil {
            self.textColor = Theme.Color.Text.black
        }

        self.font = Theme.Font.semibold(size: .exSmall)
    }
}
