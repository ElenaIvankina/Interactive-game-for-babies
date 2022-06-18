//
//  TextOnlyCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 18.06.2022.
//

import UIKit

class TextOnlyCell: UITableViewCell {
    
    static let reuseId = "TextOnlyCell"
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
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
        addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: 4),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: 4),
            questionLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: -4),
            questionLabel
                .bottomAnchor
                .constraint(equalTo: bottomAnchor,
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
