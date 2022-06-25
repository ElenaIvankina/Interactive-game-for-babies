//
//  StartGameButton.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 14.06.2022.
//

import UIKit

class StartGameButton: UIButton {

    var image: UIImage? = UIImage(named: "notes") {
        didSet {
            setImage(image, for: .normal)
        }
    }

    var bgColor: UIColor = .lightGray {
        didSet {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            self.bgColor
                .getRed(&r, green: &g, blue: &b, alpha: &a)
            let color = UIColor.rgba(r, g, b, alpha: a)

            backgroundColor = color
        }
    }

    var borderColor: UIColor = UIColor.lightGray {
        didSet {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            borderColor
                .getRed(&r, green: &g, blue: &b, alpha: &a)
            let color = UIColor.rgba(r, g, b, alpha: a)

            layer.borderColor = color.cgColor
        }
    }

    private var bevel = 3 // Button 'pop-out' effect amount

    override open var isHighlighted: Bool {
        didSet {
            isHighlighted ? pressed() : released()
        }
    }

    override open var isEnabled: Bool {
        didSet {
            isHighlighted ? released() : pressed()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeNeuromorphic()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeNeuromorphic()
    }

    private func pressed() {
        layer.shadowOffset = CGSize(width: -2, height: -2)
        layer.sublayers?[0].shadowOffset = CGSize(width: 2, height: 2)
        contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)
    }

    private func released() {
        layer.shadowOffset = CGSize(width: bevel, height: bevel)
        layer.sublayers?[0].shadowOffset = CGSize(width: -bevel, height: -bevel)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 2)
    }

    public func makeNeuromorphic(cornerRadius: CGFloat = 20.0, superView: UIView? = nil) {
        let darkShadow = darkShadowColor(.gameButton)
        let lightShadow = lightShadowColor(.gameButton)

        if (layer.sublayers?[0] as? CAShapeLayer) != nil {
            layer.sublayers?.remove(at: 0)
        }

        tintColor = .label

        let shadowLayer = CAShapeLayer()

        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.cornerCurve = .continuous

        layer.shadowRadius = 2
        shadowLayer.shadowRadius = 2

        layer.shadowOpacity = 1
        shadowLayer.shadowOpacity = 1

        layer.shadowOffset = CGSize(width: bevel, height: bevel)
        shadowLayer.shadowOffset = CGSize(width: -bevel, height: -bevel)

        var activeColor = UIColor.gameButton
        if traitCollection.userInterfaceStyle == .dark {
            activeColor = UIColor.blue
            layer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowColor = darkShadow.cgColor
        } else {
            layer.shadowColor = lightShadow.cgColor
            shadowLayer.shadowColor = UIColor.white.cgColor
        }

        layer.masksToBounds = false
        shadowLayer.frame = bounds
        layer.backgroundColor = activeColor.cgColor
        shadowLayer.backgroundColor = activeColor.cgColor

        if superView != nil {
            superview?.backgroundColor = activeColor
        }

        layer.insertSublayer(shadowLayer, at: 0)
    }

    func lightShadowColor(_ color: UIColor) -> UIColor {
        return color.adjustSaturation(by: 0.5)
    }

    func darkShadowColor(_ color: UIColor) -> UIColor {
        return color.adjustBrightness(by: 0.5)
    }
}
