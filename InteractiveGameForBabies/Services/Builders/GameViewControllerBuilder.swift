//
//  GameViewControllerBuilder.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import UIKit

class GameViewControllerBuilder {

    static func buildGameSession(typeOfGame: TypeOfGame) {
        GameStrategy.setUpGameSession(typeOfGame: typeOfGame)
        GameSession.shared.currentQuestion = GameSession.shared.getRandomQuestion(questionsArray: GameSession.shared.questionsArray)
        GameSession.shared.currentRandomCards = GameSession.shared.getRandomCards(cardsArray: GameSession.shared.cardsArray)
        GameSession.shared.numberOfRightAnswers = GameSession.shared.countRightAnswers(
            sample: GameSession.shared.currentQuestion.card,
            cards: GameSession.shared.currentRandomCards)
    }

    static func buildAnimalGame() -> GameViewController {
        buildGameSession(typeOfGame: .speakAnimalGame)
        let gameDelegate = GameDelegate()
        let viewController = GameViewController(gameDelegate: gameDelegate, typeOfGame: .speakAnimalGame)
        gameDelegate.gameViewController = viewController
        return viewController
    }

    static func buildColorGame() -> GameViewController {
        buildGameSession(typeOfGame: .colorGame)
        let gameDelegate = GameDelegate()
        let viewController = GameViewController(gameDelegate: gameDelegate, typeOfGame: .colorGame)
        gameDelegate.gameViewController = viewController
        return viewController
    }

    static func buildCountGame() -> GameViewController {
        buildGameSession(typeOfGame: .countGame)
        let gameDelegate = GameDelegate()
        let viewController = GameViewController(gameDelegate: gameDelegate, typeOfGame: .countGame)
        gameDelegate.gameViewController = viewController
        return viewController
    }

    static func buildFigureGame() -> GameViewController {
        buildGameSession(typeOfGame: .figureGame)
        let gameDelegate = GameDelegate()
        let viewController = GameViewController(gameDelegate: gameDelegate, typeOfGame: .figureGame)
        gameDelegate.gameViewController = viewController
        return viewController
    }
}
