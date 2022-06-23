//
//  AnswerCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class AnswerCell: UICollectionViewCell {

    static let reuseId = "AnswerCell"
    private let borderColor = UIColor.answerCellBorder.cgColor

    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let checkImageView: UIImageView = {
        let checkmark = UIImage(systemName: "checkmark")
        let checkmarkUIImageView = UIImageView(image: checkmark)
        checkmarkUIImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkUIImageView.tintColor = .correct
        return checkmarkUIImageView
    }()

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
        checkImageView.removeFromSuperview()
        self.isUserInteractionEnabled = true
    }

    func animateRightAnswer() {

        addSubview(checkImageView)

        NSLayoutConstraint.activate([
            checkImageView.topAnchor.constraint(equalTo: topAnchor),
            checkImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.6
        animation.autoreverses = false
        checkImageView.layer.add(animation, forKey: "alpha")
    }

    func animateWrongAnswer() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.autoreverse, .repeat, .curveEaseIn]) {
                self.backgroundColor = .red
                self.layer.borderColor = UIColor.error.cgColor
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.layer.removeAllAnimations()
            self.backgroundColor = .systemBackground
            self.layer.borderColor = self.borderColor
        }
    }
}
