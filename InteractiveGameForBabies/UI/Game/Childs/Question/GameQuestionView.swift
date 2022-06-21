//
//  GameQuestionViewNoTable.swift
//  InteractiveGameForBabies
//
//  Created by Павел Черняев on 21.06.2022.
//

import Foundation
import UIKit


class PlayButton: UIButton {}

class GameQuestionView: UIView {
    private let typeOfGame: TypeOfGame
    private var playButton: PlayButton?
    weak var delegate: GameQuestionVCDelegate?
    
    init?(typeOfGame: TypeOfGame) {
        self.typeOfGame = typeOfGame
        super.init(frame: CGRect.zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addUILabel(text: String) {
        let label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -72),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addUIImageView(named: String) {
        let image = UIImage(named: named)
        let imageView = UIImageView(image: image)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addPlaySoundButton() {
        let buttonSize: CGSize = CGSize(width: 64, height: 64)
        self.playButton = PlayButton()
        guard let playButton = self.playButton else { return }
        addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        playButton.setImage(UIImage(systemName: "music.quarternote.3"), for: .selected)
        playButton.contentHorizontalAlignment = .fill
        playButton.contentVerticalAlignment = .fill
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.systemGray2.cgColor
        playButton.layer.cornerRadius = 12
        playButton.addTarget(self, action: #selector(handlePlaySoundButton), for: .allEvents)
        
        
        NSLayoutConstraint.activate([
            playButton.heightAnchor.constraint(equalToConstant: buttonSize.height),
            playButton.widthAnchor.constraint(equalToConstant: buttonSize.width),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -8),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
    private func setupViews() {
        let question = GameSession.shared.currentQuestion
        var isAddImage = false
        var isAddPlayBtn = false
        var imageName = ""
        
        if let colorCard = question.card as? ColorCard {
            imageName = colorCard.imageName
            isAddImage = true
        }
        
        if let countCard = question.card as? CountCard {
            imageName = countCard.imageName
            isAddImage = true
        }
        
        if let _ = question.card as? AnimalCard {
            isAddPlayBtn = true
        }
        
        addUILabel(text: question.questionText)
        if isAddImage { addUIImageView(named: imageName) }
        if isAddPlayBtn { addPlaySoundButton()}
    }
    
    @objc
    func handlePlaySoundButton(sender: AnyObject) {
        if let playSoundButton = sender as? UIButton {
            delegate?.registerPlayer()
            let curState = playSoundButton.isSelected
            playSoundButton.isSelected = !curState
            delegate?.didTapPlayButtonInCell(isPlaying: curState)
        }
    }
    
    func changePlayButtonState() {
        guard let playButton = self.playButton else { return }
        let curState = playButton.isSelected
        playButton.isSelected = !(curState)
    }
}
