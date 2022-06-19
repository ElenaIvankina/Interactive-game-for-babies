//
//  QuestionTextOnlyCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 18.06.2022.
//

import UIKit

class QuestionTextOnlyCell: UITableViewCell {
    
    static let reuseId = "TextOnlyCell"
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
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
        
        NSLayoutConstraint.activate([
            questionLabel
                .topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: 4),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: -4),
            questionLabel
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: 4),
            questionLabel
                .bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: -4),
        ])
    }
    
    func configure(with text: String) {
        questionLabel.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLabel.text = nil
    }
}
