//
//  Animation.swift
//  InteractiveGameForBabies
//
//  Created by Павел Черняев on 24.06.2022.
//

import UIKit

class Animation {
    static func transformAnimation(view: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi*2
        animation.duration = 0.7
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        view.layer.add(animation, forKey: nil)
    }
    
    static func changeAlphaAnimation(view: UIView, fromValue: Any?, toValue: Any?) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.6
        animation.autoreverses = false
        view.layer.add(animation, forKey: nil)
    }
}
