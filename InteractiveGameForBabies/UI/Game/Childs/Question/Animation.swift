//
//  Animation.swift
//  InteractiveGameForBabies
//
//  Created by Павел Черняев on 24.06.2022.
//

import UIKit

class Animation {
    
    static let keyRightAnswer = "keyRightAnswer"
    static let keyWrongAnswer = "keyWrongAnswer"
    static let alphaAnimation = "alphaAnimation"
    
    private let checkImageView: UIImageView = {
        let checkmark = UIImage(systemName: "checkmark")
        let checkmarkUIImageView = UIImageView(image: checkmark)
        checkmarkUIImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkUIImageView.tintColor = .correct
        return checkmarkUIImageView
    }()
    
    private let xMarkImageView: UIImageView = {
        let xMark = UIImage(systemName: "xmark")
        let xMarkUIImageView = UIImageView(image: xMark)
        xMarkUIImageView.translatesAutoresizingMaskIntoConstraints = false
        xMarkUIImageView.tintColor = .error
        xMarkUIImageView.alpha = 0
        return xMarkUIImageView
    }()
    
    
    func transformAnimation(view: UIView, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi*2
        animation.duration = duration
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        view.layer.add(animation, forKey: nil)
    }
    
    func changeAlphaAnimation(view: UIView, fromValue: Any?, toValue: Any?, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.autoreverses = false
        animation.setValue(Self.alphaAnimation, forKey: Self.alphaAnimation)
        view.layer.add(animation, forKey: nil)
    }
    
    func makeAnimationRightAnswer(view: UIView, duration: CFTimeInterval) -> (animation: CABasicAnimation?, markView: UIImageView) {
        view.addSubview(checkImageView)

        NSLayoutConstraint.activate([
            checkImageView.topAnchor.constraint(equalTo: view.topAnchor),
            checkImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            checkImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            checkImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        animation.autoreverses = false
        return (animation, checkImageView)
    }
    
    func makeAnimationWrongAnswer(view: UIView, duration: CFTimeInterval) -> (animation: CABasicAnimation?, markView: UIImageView) {
        view.addSubview(xMarkImageView)

        let sizeSuperView = xMarkImageView.superview?.layer.frame.size
        guard let heightSuperView = sizeSuperView?.height else { return  (nil, xMarkImageView) }
        guard let widthSuperView = sizeSuperView?.width else { return (nil, xMarkImageView) }
        let heightWigth = heightSuperView > widthSuperView ? widthSuperView : heightSuperView

        NSLayoutConstraint.activate([
            xMarkImageView.heightAnchor.constraint(equalToConstant: heightWigth),
            xMarkImageView.widthAnchor.constraint(equalToConstant: heightWigth),
            xMarkImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            xMarkImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = duration
        animation.autoreverses = true
        animation.setValue(Self.keyWrongAnswer, forKey: Self.keyWrongAnswer)
        return (animation, xMarkImageView)
    }
}
