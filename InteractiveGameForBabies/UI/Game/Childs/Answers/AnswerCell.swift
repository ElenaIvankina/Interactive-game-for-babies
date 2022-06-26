//
//  AnswerCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class AnswerCell: UICollectionViewCell, CAAnimationDelegate {

    private let borderColor = UIColor.answerCellBorder.cgColor
    private var markViewRight: UIImageView?
    private var markViewWrong: UIImageView?

    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let animation = Animation()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with card: CardProtocol) {

        if let image: UIImage = UIImage(named: card.imageName) {
            cardImageView.image = image
        }

    }
    
    private func setupView() {
        contentView.addSubview(cardImageView)

        NSLayoutConstraint.activate([
            cardImageView
                .topAnchor
                .constraint(equalTo: contentView.topAnchor),
            cardImageView
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor),
            cardImageView
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor),
            cardImageView
                .bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor)
        ])

        layer.borderWidth = 1.5
        layer.borderColor = self.borderColor
        layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
        
        if let animationView = markViewRight {
            animationView.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }

    func animateRightAnswer(duration: CFTimeInterval) {
        let result = animation.makeAnimationRightAnswer(view: self,duration: duration)
        if let rightAnimation = result.animation {
            markViewRight = result.markView
            markViewRight?.layer.add(rightAnimation, forKey: Animation.keyRightAnswer)
        }
    }

    func animateWrongAnswer(duration: CFTimeInterval) {
        let result = animation.makeAnimationWrongAnswer(view: self, duration: duration)
        if let wrongAnimation = result.animation {
            wrongAnimation.delegate = self
            markViewWrong = result.markView
            markViewWrong?.layer.add(wrongAnimation, forKey: Animation.keyWrongAnswer)
        }
    }
    
    func animationChangeImageAndFlip(card: CardProtocol, duration: CFTimeInterval) {
        guard let card = card as? FigureCard else { return }
        let transitionFlip = UIView.AnimationOptions.transitionFlipFromTop
        
        let duration = 0.6
        UIView.transition(with: self, duration: duration, options: transitionFlip, animations: nil) { _ in
            let imageName = card.imageNameFill
            if imageName.isEmpty { return }
            let image = UIImage(named: imageName)
            self.cardImageView.image = image
            self.animation.changeAlphaAnimation(view: self, fromValue: 0, toValue: 1, duration: duration)
            self.animateRightAnswer(duration: duration)
        }
        animation.changeAlphaAnimation(view: self, fromValue: 1, toValue: 0, duration: duration)
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let value = anim.value(forKey: Animation.keyWrongAnswer) as? String else { return }
        if value == Animation.keyWrongAnswer {
            markViewWrong?.removeFromSuperview()
        }
    }
}
