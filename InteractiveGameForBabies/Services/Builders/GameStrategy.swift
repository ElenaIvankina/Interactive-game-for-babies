//
//  GameStrategy.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 18.06.2022.
//

import Foundation

enum TypeOfGame: Int {
    case speakAnimalGame
    case colorGame
    case countGame
    case figureGame
}

protocol GameStrategyProtocol {
    static func setUpGameSession(typeOfGame: TypeOfGame)
}

class GameStrategy: GameStrategyProtocol {

    static func clearGameSession () {
        GameSession.shared.counterOfRightAnswers = 0

    }

    static func setUpGameSession (typeOfGame: TypeOfGame) {

        clearGameSession()

        switch typeOfGame {
        case .speakAnimalGame:
            GameSession.shared.questionsArray = GameDatabase.shared.animalQuestions
            GameSession.shared.cardsArray = GameDatabase.shared.animalCards
        case .colorGame:
            GameSession.shared.questionsArray = GameDatabase.shared.colorQuestions
            GameSession.shared.cardsArray = GameDatabase.shared.colorCards
        case .countGame:
            GameSession.shared.questionsArray = GameDatabase.shared.countQuestions
            GameSession.shared.cardsArray = GameDatabase.shared.countCards
        case .figureGame:
            GameSession.shared.questionsArray = GameDatabase.shared.figureQuestions
            GameSession.shared.cardsArray = GameDatabase.shared.figureCards
        }
    }
}
