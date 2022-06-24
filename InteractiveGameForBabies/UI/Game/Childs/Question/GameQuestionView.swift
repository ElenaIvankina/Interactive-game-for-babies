//
//  GameQuestionView.swift
//  InteractiveGameForBabies
//
//  Created by Павел Черняев on 21.06.2022.
//

import Foundation
import UIKit

class GameQuestionView: UIView {

    private let typeOfGame: TypeOfGame
    weak var delegate: GameQuestionViewControllerDelegate?

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .mainText
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()

    private let questionImage: UIImageView? = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let playButton: UIButton? = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.setImage(UIImage(systemName: "music.quarternote.3"), for: .selected)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.playButtonBorder.cgColor
        button.layer.cornerRadius = 12
        return button
    }()

    private enum Constants {
        static let leading: CGFloat = 8
        static let trailing: CGFloat = -8
        static let buttonSize: CGSize = CGSize(width: 64, height: 64)
        static let imageSize: CGSize = CGSize(width: 64, height: 64)
    }

    init(typeOfGame: TypeOfGame) {
        self.typeOfGame = typeOfGame
        super.init(frame: CGRect.zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setQuestion(text: String) {
        questionLabel.text = text
    }

    func setQuestionImage(imageName: String) {
        guard let imageView = questionImage else { return }
        imageView.image = UIImage(named: imageName)
    }

    private func addQuestionUILabel(text: String) {
        questionLabel.text = text
        addSubview(questionLabel)

        NSLayoutConstraint.activate([
            questionLabel
                .topAnchor
                .constraint(equalTo: topAnchor),
            questionLabel
                .leadingAnchor
                .constraint(equalTo: leadingAnchor,
                            constant: Constants.leading),
            questionLabel
                .bottomAnchor
                .constraint(equalTo: bottomAnchor)
        ])
    }

    private func addQuestionUIImageView(named: String) {
        guard let imageView = questionImage else { return }
        imageView.image = UIImage(named: named)

        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView
                .heightAnchor
                .constraint(equalToConstant: Constants.imageSize.height),
            imageView
                .widthAnchor
                .constraint(equalToConstant: Constants.imageSize.width),
            imageView
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: Constants.trailing),
            imageView
                .centerYAnchor
                .constraint(equalTo: centerYAnchor),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: imageView.leadingAnchor)
        ])
    }

    private func addPlaySoundButton() {
        guard let playButton = self.playButton else { return }
        addSubview(playButton)

        playButton.addTarget(self,
                             action: #selector(handlePlaySoundButton),
                             for: .allEvents)

        NSLayoutConstraint.activate([
            playButton
                .heightAnchor
                .constraint(equalToConstant: Constants.buttonSize.height),
            playButton
                .widthAnchor
                .constraint(equalToConstant: Constants.buttonSize.width),
            playButton
                .trailingAnchor
                .constraint(equalTo: trailingAnchor,
                            constant: Constants.trailing),
            playButton
                .centerYAnchor
                .constraint(equalTo: centerYAnchor),
            questionLabel
                .trailingAnchor
                .constraint(equalTo: playButton.leadingAnchor)
        ])
    }

    private func setupViews() {
        let question = GameSession.shared.currentQuestion

        addQuestionUILabel(text: question.questionText)

        if let colorCard = question.card as? ColorCard {
            let imageName = colorCard.imageName
            addQuestionUIImageView(named: imageName)
        }

        if let countCard = question.card as? CountCard {
            let imageName = countCard.imageName
            addQuestionUIImageView(named: imageName)
        }

        if let _ = question.card as? AnimalCard {
            addPlaySoundButton()
        }
    }

    @objc
    func handlePlaySoundButton(sender: AnyObject) {
        if let playSoundButton = sender as? UIButton {
            delegate?.registerPlayer()
            let curState = playSoundButton.isSelected
            playSoundButton.isSelected = !curState
            delegate?.didTapPlayButton(isPlaying: curState)
        }
    }

    func changePlayButtonState() {
        guard let playButton = self.playButton else { return }
        let curState = playButton.isSelected
        playButton.isSelected = !(curState)
    }
}
