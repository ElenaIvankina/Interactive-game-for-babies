//
//  GameViewControllerBuilder.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import UIKit

class GameViewControllerBuilder {

    func buildNewGameSession(typeOfGame: TypeOfGame) {
        GameStrategy.setUpGameSession(typeOfGame: typeOfGame)
        GameSession.shared.currentQuestion = GameSession.shared.getRandomQuestion(questionsArray: GameSession.shared.questionsArray)
        print(GameSession.shared.currentQuestion)
        GameSession.shared.currentRandomCards = GameSession.shared.getRandomCards(cardsArray: GameSession.shared.cardsArray)
        print(GameSession.shared.currentRandomCards)
        GameSession.shared.numberOfRightAnswers = GameSession.shared.countRightAnswers(
            sample: GameSession.shared.currentQuestion.card,
            cards: GameSession.shared.currentRandomCards)
    }

    func buildGame(typeOfGame: TypeOfGame) -> GameViewController {
        buildNewGameSession(typeOfGame: typeOfGame)
        let gameDelegate = GameDelegate()
        let viewController = GameViewController(gameDelegate: gameDelegate, typeOfGame: typeOfGame)
        gameDelegate.gameViewController = viewController
        return viewController
    }
}
