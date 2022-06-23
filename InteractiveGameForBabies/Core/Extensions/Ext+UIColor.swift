//
//  Ext+UIColor.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 15.06.2022.
//

import UIKit

extension UIColor {

    static let mainText = UIColor(hexString: "#002357")
    static let gameButton = UIColor(hexString: "#ffd802")
    static let gameButtonBorder = UIColor(hexString: "#024d8c")
    static let gameNameText = UIColor(hexString: "#FFFFDB")

    static let answerCellBorder = UIColor(hexString: "#013766")

    static let error = UIColor(hexString: "#C92243")
    static let correct = UIColor(hexString: "#68ef00")

    static let gradientStart = UIColor(hexString: "#06dcfb")
    static let gradientEnd = UIColor(hexString: "#4884ee")

    static let playButtonBorder = UIColor(hexString: "#bdef53")

    private static var colorsCache: [String: UIColor] = [:]

    public static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat) -> UIColor {
        let key = "\(red), \(green), \(blue), \(alpha)"

        if let cachedColor = colorsCache[key] {
            return cachedColor
        }

        clearColorsCacheIfNeeded()

        let color = UIColor(red: red,
                            green: green,
                            blue: blue,
                            alpha: alpha)

        colorsCache[key] = color

        return color
    }

    public func adjustSaturation(by value: CGFloat) -> UIColor {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0

        if self.getHue(&h,
                       saturation: &s,
                       brightness: &b,
                       alpha: &a) {
            s = max(0, s - value)
            return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
        }

        return self
    }

    public func adjustBrightness(by value: CGFloat) -> UIColor {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0

        if self.getHue(&h,
                       saturation: &s,
                       brightness: &b,
                       alpha: &a) {
            b = (b - value).clamped(to: 0...1)
            return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
        }

        return self
    }

    private static func clearColorsCacheIfNeeded() {
        guard colorsCache.count >= 100 else { return }
        colorsCache = [:]
    }

    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var color: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Comparable {

    func clamped(to range: ClosedRange<Self>) -> Self {
        if self > range.upperBound {
            return range.upperBound
        } else if self < range.lowerBound {
            return range.lowerBound
        } else {
            return self
        }
    }
}
