//
//  QuestionImageCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 18.06.2022.
//

import UIKit

class QuestionImageCell: UITableViewCell {
    
    static let reuseId = "ImageCell"
    
    private enum Constants {
        static let inset: CGFloat = 4
        static let imageSize: CGSize = CGSize(width: 64, height: 64)
    }
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    private let infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupView() {
        contentView.addSubview(questionLabel)
        contentView.addSubview(infoImage)
        
        NSLayoutConstraint.activate([
            questionLabel
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: -Constants.inset),
            questionLabel
                .centerYAnchor
                .constraint(equalTo: infoImage.centerYAnchor),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: infoImage.leadingAnchor,
                            constant: Constants.inset),
            
            infoImage
                .widthAnchor
                .constraint(equalToConstant: Constants.imageSize.width),
            infoImage
                .heightAnchor
                .constraint(equalToConstant: Constants.imageSize.height),
            infoImage
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: -Constants.inset),
            infoImage
                .topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: Constants.inset),
            infoImage
                .bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: -Constants.inset)
        ])
    }
    
    func configure() {
        questionLabel.text = GameSession.shared.currentQuestion.questionText
        let imageName = GameSession.shared.currentQuestion.card.imageName
        
        if let image: UIImage = UIImage(named: imageName) {
            infoImage.image = image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        questionLabel.text = nil
        infoImage.image = nil
    }
}
