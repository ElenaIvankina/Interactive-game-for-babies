//
//  GameQuestionViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit
import AVFoundation

protocol GameQuestionViewControllerDelegate: AnyObject {
    func didTapPlayButtonInCell(isPlaying: Bool)
    func registerPlayer()
}

class GameQuestionViewController: UIViewController {
 
    private let typeOfGame: TypeOfGame
    
    private var player: AVPlayer?

    //MARK: - Lifecycle
    init(typeOfGame: TypeOfGame) {
        self.typeOfGame = typeOfGame
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let gameQuestionView = GameQuestionView(typeOfGame: self.typeOfGame)
        gameQuestionView?.delegate = self
        self.view = gameQuestionView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        didTapPlayButtonInCell(isPlaying: true)
        if self.player != nil {
            NotificationCenter.default.removeObserver(self)
        }
        super.viewDidDisappear(animated)
    }
}

extension GameQuestionViewController: GameQuestionViewControllerDelegate {
    func didTapPlayButtonInCell(isPlaying: Bool) {
        guard let player = self.player else { return }
        if isPlaying {
            player.replaceCurrentItem(with: nil)
        } else {
            guard let animalCard = GameSession.shared.currentQuestion.card as? AnimalCard,
                  let url = Bundle
                    .main
                    .url(forResource: animalCard.sound,
                         withExtension: "mp3")
            else { return }
            
            player.replaceCurrentItem(with: AVPlayerItem(url: url))
            
            if player.timeControlStatus != .playing {
                player.play()
            }
        }
    }
    
    func registerPlayer() {
        if self.player == nil {
            self.player = AVPlayer()
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(endPlayeng),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: player?.currentItem)
        }
    }
    
    @objc
    func endPlayeng() {
        if let viewGameQuestionView = self.view as? GameQuestionView {
            viewGameQuestionView.changePlayButtonState()
        }
    }
}
