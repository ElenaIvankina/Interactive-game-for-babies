//
//  GameStrategy.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 18.06.2022.
//

import Foundation

enum TypeOfGame {
    case speakAnimalGame
    case colorGame
    case countGame
    case figureGame
}

protocol GameStrategyProtocol {
    static func setUpGameSession(gameSession: GameSessionProtocol, typeOfGame: TypeOfGame)
}

class GameStrategy: GameStrategyProtocol {
    
    static func setUpGameSession (gameSession: GameSessionProtocol, typeOfGame: TypeOfGame) {
        let gameSession = gameSession
        
        switch typeOfGame {
        case .speakAnimalGame:
            gameSession.questionsArray = GameDatabase.shared.animalQuestions
            gameSession.cardsArray = GameDatabase.shared.animalCards
        case .colorGame:
            gameSession.questionsArray = GameDatabase.shared.colorQuestions
            gameSession.cardsArray = GameDatabase.shared.colorCards
        case .countGame:
            gameSession.questionsArray = GameDatabase.shared.countQuestions
            gameSession.cardsArray = GameDatabase.shared.countCards
        case .figureGame:
            gameSession.questionsArray = GameDatabase.shared.figureQuestions
            gameSession.cardsArray = GameDatabase.shared.figureCards
        }
    }
}
