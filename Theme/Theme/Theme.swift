//
//  Theme.swift
//  Theme
//
//  Created by Ankur Kesharwani on 31/01/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

public class Theme {
    public class Font {
        public enum Size: Float {
            case exSmall = 10
            case small = 12
            case regular = 14
            case large = 18
            case exLarge = 24
        }
        
        public class func light(size: Size) -> UIFont {
            return Font.light(size: CGFloat(size.rawValue))
        }

        public class func light(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: UIFontWeightLight)
        }

        public class func regular(size: Size) -> UIFont {
            return Font.regular(size: CGFloat(size.rawValue))
        }

        public class func regular(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: UIFontWeightRegular)
        }

        public class func semibold(size: Size) -> UIFont {
            return Font.semibold(size: CGFloat(size.rawValue))
        }

        public class func semibold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: UIFontWeightSemibold)
        }

        public class func bold(size: Size) -> UIFont {
            return Font.bold(size: CGFloat(size.rawValue))
        }

        public class func bold(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: UIFontWeightBold)
        }
    }

    
    public class Color {
        public static var keyToColorMap = [
            "Color.skyBlue": Color.skyBlue,
            "Color.muddyRed": Color.muddyRed,
            "Color.white": Color.white,
            "Color.black": Color.black,
            "Color.Text.grayDark": Color.Text.grayDark,
            "Color.Text.grayLight": Color.Text.grayLight,
            "Color.Text.black": Color.Text.black,
            "Color.Text.white": Color.Text.white,
            "Color.Background.white": Color.Background.white,
            "Color.Background.clear": Color.Background.clear,
            "Color.Border.primary": Color.Border.primary,
            "Color.Border.native": Color.Border.native,
        ] as [String: UIColor]

        
        public class var skyBlue: UIColor {
            return UIColor(red: 75.0 / 255.0, green: 181.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        }
        
        public class var muddyRed: UIColor {
            return UIColor(red: 234.0 / 255.0, green: 79.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
        }
        
        public class var white: UIColor {
            return UIColor.white
        }
        
        public class var black: UIColor {
            return UIColor.black
        }
        
        public class Text {

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
        

        public class Background {
            public class var white: UIColor {
                return UIColor.white
            }
            
            public class var clear: UIColor {
                return UIColor.clear
            }
        }

        
        public class Border {

            public class var primary: UIColor {
                return UIColor(red: 216.0 / 255.0, green: 216.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0)
            }
            
            public class var native: UIColor {
                return UIColor(red: 170.0 / 255.0, green: 170.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
            }
        }
    }
}
