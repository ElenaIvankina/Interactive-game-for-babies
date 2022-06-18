//
//  QuestionImageCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 18.06.2022.
//

import UIKit

class QuestionImageCell: UITableViewCell {
    
    static let reuseId = "ImageCell"
    
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
        addSubview(questionLabel)
        addSubview(infoImage)
        
        NSLayoutConstraint.activate([
            questionLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: -4),
            questionLabel
                .centerYAnchor
                .constraint(equalTo: infoImage.centerYAnchor),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: infoImage.leadingAnchor,
                            constant: 4),
            
            infoImage
                .widthAnchor
                .constraint(equalToConstant: 64),
            infoImage
                .heightAnchor
                .constraint(equalToConstant: 64),
            infoImage
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: -4),
            infoImage
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: 4),
            infoImage
                .bottomAnchor
                .constraint(equalTo: bottomAnchor,
                            constant: -4)
        ])
    }
    
    func configure(with text: String, image name: String) {
        questionLabel.text = text
        infoImage.image = UIImage(named: name)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        questionLabel.text = nil
        infoImage.image = nil
    }
}
