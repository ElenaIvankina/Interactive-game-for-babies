//
//  AnswerCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit

class AnswerCell: UICollectionViewCell {
    
    static let reuseId = "AnswerCell"
    
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
        layer.borderColor = UIColor.blue.cgColor
        layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cardImageView.image = nil
    }
}
