//
//  AnswerCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class AnswerCell: UICollectionViewCell {

    static let reuseId = "AnswerCell"
    private let borderColor = UIColor.blue.cgColor
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with indexPath: IndexPath) {

        if let image: UIImage = UIImage(named: GameSession.shared.currentRandomCards[indexPath.row].imageName) {
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

        layer.borderWidth = 1.0
        layer.borderColor = self.borderColor
        layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
    }
    
    func animateRightAnswer() {
        let checkmark = UIImage(systemName: "checkmark")
        
        let checkmarkUIImageView = UIImageView(image: checkmark)
        checkmarkUIImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkUIImageView.tintColor = .green
        addSubview(checkmarkUIImageView)
        
        NSLayoutConstraint.activate([
            checkmarkUIImageView.topAnchor.constraint(equalTo: topAnchor),
            checkmarkUIImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkmarkUIImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkmarkUIImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.6
        animation.autoreverses = false
        checkmarkUIImageView.layer.add(animation, forKey: "alpha")
    }
    
    func animateWrongAnswer() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.autoreverse, .repeat, .curveEaseIn]) {
                self.backgroundColor = .red
                self.layer.borderColor = UIColor.red.cgColor
            }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.layer.removeAllAnimations()
            self.backgroundColor = .systemBackground
            self.layer.borderColor = self.borderColor
        }
    }
}
