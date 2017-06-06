//
//  Theme.swift
//  Theme
//
//  Created by Ankur Kesharwani on 31/01/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit

public enum ThemeFontSize: Float {
    case exSmall = 10
    case small = 12
    case regular = 14
    case large = 18
    case exLarge = 24
}

public protocol ThemeFont {
    static func light(size: ThemeFontSize) -> UIFont
    static func light(size: CGFloat) -> UIFont
    static func regular(size: ThemeFontSize) -> UIFont
    static func regular(size: CGFloat) -> UIFont
    static func semibold(size: ThemeFontSize) -> UIFont
    static func semibold(size: CGFloat) -> UIFont
    static func bold(size: ThemeFontSize) -> UIFont
    static func bold(size: CGFloat) -> UIFont
}

public protocol ThemeColor {
    static var skyBlue: UIColor { get }
    static var muddyRed: UIColor { get }
    static var white: UIColor { get }
    static var black: UIColor { get }
    
    static var Text: ThemeColorText.Type { get }
    static var Background: ThemeColorBackground.Type { get }
    static var Border: ThemeColorBorder.Type { get }
}

public protocol ThemeColorText {
    static var grayDark: UIColor { get }
    static var grayLight: UIColor { get }
    static var white: UIColor { get }
    static var black: UIColor { get }
    static var green: UIColor { get }
}

public protocol ThemeColorBackground {
    static var white: UIColor { get }
    static var clear: UIColor { get }
}

public protocol ThemeColorBorder {
    static var primary: UIColor { get }
    static var native: UIColor { get }
}

public class Theme {
    public static var Font: ThemeFont.Type = LightThemeFont.self
    public static var Color: ThemeColor.Type = LightThemeColor.self
    
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
    
    static func setLightTheme() {
        Theme.Font = LightThemeFont.self
        Theme.Color = LightThemeColor.self
    }
}
