//
//  GameQuestionViewController.swift
//  InteractiveGameForBabies
//
//  Created by Дмитрий Дуденин on 16.06.2022.
//

import UIKit
import AVFoundation

protocol GameQuestionViewControllerDelegate: AnyObject {
    func didTapPlayButton(isPlaying: Bool)
    func registerPlayer()
}

class GameQuestionViewController: UIViewController {

    private lazy var gameQuestionView = GameQuestionView(typeOfGame: self.typeOfGame)
    private let typeOfGame: TypeOfGame

    private var player: AVPlayer?

    var contentHeight: CGFloat {
        return 64
    }

    // MARK: - Lifecycle
    init(typeOfGame: TypeOfGame) {
        self.typeOfGame = typeOfGame
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = gameQuestionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameQuestionView.delegate = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopPlayer()
        NotificationCenter.default.removeObserver(self)
    }

    func reloadData(question: QuestionProtocol) {
        gameQuestionView.setQuestion(text: question.questionText)
        gameQuestionView.setQuestionImage(imageName: question.card.imageName)
        stopPlayer()
    }

    private func stopPlayer() {
        guard let player = self.player else { return }

        if player.timeControlStatus == .playing {
            gameQuestionView.changePlayButtonState()
        }
        didTapPlayButton(isPlaying: true)
    }
}

extension GameQuestionViewController: GameQuestionViewControllerDelegate {
    func didTapPlayButton(isPlaying: Bool) {
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
        if player == nil {
            player = AVPlayer()
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(endPlaying),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: player?.currentItem)
        }
    }

    @objc
    func endPlaying() {
            gameQuestionView.changePlayButtonState()
    }
}
