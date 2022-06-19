//
//  QuestionSoundCell.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 18.06.2022.
//

import UIKit

protocol QuestionSoundCellDelegate: AnyObject {
    func didTapPlayButtonInCell(isPlaying: Bool)
}

class QuestionSoundCell: UITableViewCell {
    
    static let reuseId = "SoundCell"
    weak var delegate: QuestionSoundCellDelegate?
    
    private enum Constants {
        static let inset: CGFloat = 4
        static let buttonSize: CGSize = CGSize(width: 32, height: 32)
    }
    
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
        contentView.addSubview(questionLabel)
        contentView.addSubview(playSoundButton)
        
        playSoundButton.addTarget(self,
                                  action: #selector(handlePlaySoundButton),
                                  for: .allEvents)
        
        NSLayoutConstraint.activate([
            questionLabel
                .trailingAnchor
                .constraint(equalTo: playSoundButton.leadingAnchor,
                            constant: -Constants.inset),
            questionLabel
                .leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor,
                            constant: -Constants.inset),
            questionLabel
                .centerYAnchor
                .constraint(equalTo: playSoundButton.centerYAnchor),
            
            playSoundButton
                .widthAnchor
                .constraint(equalToConstant: Constants.buttonSize.width),
            playSoundButton
                .heightAnchor
                .constraint(equalToConstant: Constants.buttonSize.height),
            playSoundButton
                .trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor,
                            constant: -Constants.inset),
            playSoundButton
                .topAnchor
                .constraint(equalTo: contentView.topAnchor,
                            constant: Constants.inset),
            playSoundButton
                .bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor,
                            constant: -Constants.inset)
        ])
    }
    
    func configure(with question: QuestionProtocol) {
        questionLabel.text = question.questionText
    }
    
    func resetState() {
        playSoundButton.isSelected = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        questionLabel.text = nil
    }
    
    @objc func handlePlaySoundButton() {
        let curState = playSoundButton.isSelected
        playSoundButton.isSelected = !curState
        delegate?.didTapPlayButtonInCell(isPlaying: curState)
    }
}
