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
        
        switch typeOfGame {
            case .colorGame,.countGame,.speakAnimalGame:
                GameSession.shared.currentRandomCards = GameSession.shared.getRandomCards(cardsArray: GameSession.shared.cardsArray)
                GameSession.shared.numberOfRightAnswers = GameSession.shared.countRightAnswers(
                    sample: GameSession.shared.currentQuestion.card,
                    cards: GameSession.shared.currentRandomCards)
            case .figureGame:
                GameSession.shared.currentRandomCards = GameSession.shared.findFigureAnswerToQuestion()
                GameSession.shared.numberOfRightAnswers = GameSession.shared.numberOfCardsInSession
        }
        
    }

    func buildGame(typeOfGame: TypeOfGame) -> GameViewController {
        buildNewGameSession(typeOfGame: typeOfGame)
        let gameDelegate = GameDelegate()
        let viewController = GameViewController(gameDelegate: gameDelegate, typeOfGame: typeOfGame)
        GameSession.shared.gameViewController = viewController
        gameDelegate.gameViewController = viewController
        return viewController
    }
}
