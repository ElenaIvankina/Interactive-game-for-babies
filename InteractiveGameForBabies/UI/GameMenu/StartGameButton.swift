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
            lightShadowLayer.contents = image?.cgImage
            darkShadowLayer.contents = image?.cgImage
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
    
    private var bevel = 4 // Button 'pop-out' effect amount
    
    private let darkShadowLayer = CALayer()
    private let lightShadowLayer = CALayer()
    
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        darkShadowLayer.frame = bounds
        lightShadowLayer.frame = bounds
    }
    
    private func pressed() {
        darkShadowLayer.shadowOffset = CGSize(width: -bevel, height: -bevel)
        lightShadowLayer.shadowOffset = CGSize(width: bevel, height: bevel)
        contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)
    }
    
    private func released() {
        darkShadowLayer.shadowOffset = CGSize(width: bevel, height: bevel)
        lightShadowLayer.shadowOffset = CGSize(width: -bevel, height: -bevel)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 2)
    }
    
    private func makeNeuromorphic() {
        layer.masksToBounds = false
        
        let cornerRadius: CGFloat = 20.0
        
        darkShadowLayer.frame = bounds
        darkShadowLayer.cornerRadius = cornerRadius
        darkShadowLayer.backgroundColor = UIColor.gameButton.cgColor
        darkShadowLayer.shadowColor = darkShadowColor(.gameButton, 0.35).cgColor
        darkShadowLayer.shadowOffset = CGSize(width: bevel, height: bevel)
        darkShadowLayer.shadowOpacity = 1
        darkShadowLayer.shadowRadius = 2
        darkShadowLayer.contentsGravity = .center
        layer.insertSublayer(darkShadowLayer, at: 0)
        
        lightShadowLayer.frame = bounds
        lightShadowLayer.cornerRadius = cornerRadius
        lightShadowLayer.backgroundColor = UIColor.gameButton.cgColor
        lightShadowLayer.shadowColor = lightShadowColor(.gameButton).cgColor
        lightShadowLayer.shadowOffset = CGSize(width: -bevel, height: -bevel)
        lightShadowLayer.shadowOpacity = 1
        lightShadowLayer.shadowRadius = 2
        lightShadowLayer.contentsGravity = .center
        layer.addSublayer(lightShadowLayer)
    }
    
    private func lightShadowColor(_ color: UIColor, _ value: CGFloat = 0.5) -> UIColor {
        return color.adjustSaturation(by: value)
    }
    
    private func darkShadowColor(_ color: UIColor, _ value: CGFloat = 0.5) -> UIColor {
        return color.adjustBrightness(by: value)
    }
}
