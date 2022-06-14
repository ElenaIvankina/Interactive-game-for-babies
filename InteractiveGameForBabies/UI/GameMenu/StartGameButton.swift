//
//  StartGameButton.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 14.06.2022.
//

import UIKit

extension UIColor {
    private static var colorsCache: [String: UIColor] = [:]

    public static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat) -> UIColor {
        let key = "\(red), \(green), \(blue), \(alpha)"

        if let cachedColor = self.colorsCache[key] {
            return cachedColor
        }

        self.clearColorsCacheIfNeeded()
        let color = UIColor(red: red,
                            green: green,
                            blue: blue,
                            alpha: alpha)
        self.colorsCache[key] = color
        return color
    }

    private static func clearColorsCacheIfNeeded() {
        guard self.colorsCache.count >= 100 else { return }
        colorsCache = [:]
    }
}

class StartGameButton: UIButton {
    
    var image: UIImage? = UIImage(named: "notes") {
        didSet {
            self.setImage(self.image, for: .normal)
        }
    }

    var bgColor: UIColor = UIColor.lightGray {
        didSet {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            self.bgColor
                .getRed(&r, green: &g, blue: &b, alpha: &a)
            let color = UIColor.rgba(r, g, b, alpha: a)

            self.backgroundColor = color
        }
    }

    var borderColor: UIColor = UIColor.lightGray {
        didSet {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            self.borderColor
                .getRed(&r, green: &g, blue: &b, alpha: &a)
            let color = UIColor.rgba(r, g, b, alpha: a)

            self.layer.borderColor = color.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupButton()
    }

    private func setupButton() {
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 0.25
    }
}
