//
//  DarkTheme.swift
//  Theme
//
//  Created by Ankur K on 06/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

class DarkThemeFont: ThemeFont {
    public class func light(size: ThemeFontSize) -> UIFont {
        return light(size: CGFloat(size.rawValue))
    }
    
    public class func light(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFontWeightLight)
    }
    
    public class func regular(size: ThemeFontSize) -> UIFont {
        return regular(size: CGFloat(size.rawValue))
    }
    
    public class func regular(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFontWeightRegular)
    }
    
    public class func semibold(size: ThemeFontSize) -> UIFont {
        return semibold(size: CGFloat(size.rawValue))
    }
    
    public class func semibold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFontWeightSemibold)
    }
    
    public class func bold(size: ThemeFontSize) -> UIFont {
        return bold(size: CGFloat(size.rawValue))
    }
    
    public class func bold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFontWeightBold)
    }
}

class DarkThemeColor: ThemeColor {
    public static var Border: ThemeColorBorder.Type = DarkThemeColorBorder.self
    public static var Background: ThemeColorBackground.Type = DarkThemeColorBackground.self
    public static var Text: ThemeColorText.Type = DarkThemeColorText.self
    
    public class var skyBlue: UIColor {
        return UIColor(red: 234.0 / 255.0, green: 79.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
    }
    
    public class var muddyRed: UIColor {
        return UIColor(red: 75.0 / 255.0, green: 181.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    public class var white: UIColor {
        return UIColor.white
    }
    
    public class var black: UIColor {
        return UIColor.black
    }
}

class DarkThemeColorText: ThemeColorText {
    public class var grayDark: UIColor {
        return UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    
    public class var grayLight: UIColor {
        return UIColor(red: 127.0 / 255.0, green: 127.0 / 255.0, blue: 127.0 / 255.0, alpha: 1.0)
    }
    
    public class var black: UIColor {
        return UIColor(red: 25.0 / 255.0, green: 25.0 / 255.0, blue: 25.0 / 255.0, alpha: 1.0)
    }
    
    public class var white: UIColor {
        return UIColor.white
    }
    
    public class var green: UIColor {
        return UIColor(red: 0 / 255.0, green: 162.0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
    }
}

class DarkThemeColorBackground: ThemeColorBackground {
    public class var white: UIColor {
        return UIColor.white
    }
    
    public class var clear: UIColor {
        return UIColor.clear
    }
}

class DarkThemeColorBorder: ThemeColorBorder {
    public class var primary: UIColor {
        return UIColor(red: 216.0 / 255.0, green: 216.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0)
    }
    
    public class var native: UIColor {
        return UIColor(red: 170.0 / 255.0, green: 170.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
    }
}
