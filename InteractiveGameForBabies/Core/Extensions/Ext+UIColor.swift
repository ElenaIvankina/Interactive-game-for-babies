//
//  Ext+UIColor.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 15.06.2022.
//

import UIKit

extension UIColor {

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

    private static func clearColorsCacheIfNeeded() {
        guard colorsCache.count >= 100 else { return }
        colorsCache = [:]
    }
}
