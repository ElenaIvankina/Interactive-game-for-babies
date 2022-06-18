//
//  SoundCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 18.06.2022.
//

import UIKit

class SoundCell: UITableViewCell {
    
    static let reuseId = "SoundCell"
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let playSoundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "person"), for: .normal)
        return button
    }()
    
    private var soundName: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(questionLabel)
        addSubview(playSoundButton)
        
        NSLayoutConstraint.activate([
            questionLabel
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: 4),
            questionLabel
                .bottomAnchor
                .constraint(equalTo: bottomAnchor,
                            constant: -4),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: playSoundButton.leadingAnchor,
                            constant: 4),
            questionLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: -4),

            questionLabel
                .centerYAnchor
                .constraint(equalTo: playSoundButton.centerYAnchor),
            
            playSoundButton
                .widthAnchor
                .constraint(equalToConstant: 20),
            playSoundButton
                .heightAnchor
                .constraint(equalToConstant: 20),
            playSoundButton
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: -4),
            playSoundButton
                .topAnchor
                .constraint(equalTo: topAnchor,
                            constant: 4),
            playSoundButton
                .bottomAnchor
                .constraint(equalTo: bottomAnchor,
                            constant: -4)
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
