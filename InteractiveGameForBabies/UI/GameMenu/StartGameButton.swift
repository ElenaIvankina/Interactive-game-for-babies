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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 0.25
    }
}
