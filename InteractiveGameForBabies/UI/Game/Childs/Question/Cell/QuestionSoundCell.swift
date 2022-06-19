//
//  QuestionSoundCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 18.06.2022.
//

import UIKit

protocol QuestionSoundCellDelegate: AnyObject {
    func didTapPlayButtonInCell()
}

class QuestionSoundCell: UITableViewCell {
    
    static let reuseId = "SoundCell"
    weak var delegate: QuestionSoundCellDelegate?
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    private let playSoundButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.setImage(UIImage(systemName: "music.quarternote.3"), for: .selected)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.layer.cornerRadius = 12
        return button
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
        addSubview(playSoundButton)
        
        playSoundButton.addTarget(self,
                                  action: #selector(handlePlaySoundButton),
                                  for: .allEvents)
        
        NSLayoutConstraint.activate([
            questionLabel
                .trailingAnchor
                .constraint(equalTo: playSoundButton.leadingAnchor,
                            constant: -4),
            questionLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: 4),
            questionLabel
                .centerYAnchor
                .constraint(equalTo: playSoundButton.centerYAnchor),
            
            playSoundButton
                .widthAnchor
                .constraint(equalToConstant: 32),
            playSoundButton
                .heightAnchor
                .constraint(equalToConstant: 32),
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
    
    func resetState() {
        playSoundButton.isSelected = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLabel.text = nil
    }
    
    @objc func handlePlaySoundButton() {
        guard !playSoundButton.isSelected else { return }
        
        playSoundButton.isSelected = true
        delegate?.didTapPlayButtonInCell()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard isUserInteractionEnabled,
              !isHidden,
              alpha > 0
        else {
            return nil
        }
        
        for subview in subviews.reversed() {
            let convertedPoint = subview.convert(point, from: self)
            if let buttonView = subview.hitTest(convertedPoint, with: event) as? UIButton {
                return buttonView
            }
        }
        
        return nil
    }
}
