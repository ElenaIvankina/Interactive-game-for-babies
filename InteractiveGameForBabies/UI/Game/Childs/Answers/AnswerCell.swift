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
        imageView.layer.cornerRadius = 8
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
    
    func configure(with image: UIImage?) {
        cardImageView.image = image
    }
    
    private func setupView() {
        addSubview(cardImageView)
        
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: topAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseIn]) {
                self.backgroundColor = .green
                self.layer.borderColor = UIColor.green.cgColor
            }
    }
    
    func animateWrongAnswer() {
        UIView.animate(
            withDuration: 0.3,
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
