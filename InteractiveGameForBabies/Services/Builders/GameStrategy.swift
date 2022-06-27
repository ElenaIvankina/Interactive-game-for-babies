//
//  GameStrategy.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 18.06.2022.
//

import Foundation
import UIKit

enum TypeOfGame: Int, CaseIterable {
    case speakAnimalGame
    case colorGame
    case countGame
    case figureGame
    
    var name: String {
        switch self {
        case .speakAnimalGame:
            return "Как говорят животные"
        case .countGame:
            return "Один - много"
        case .colorGame:
            return "Изучаем цвета"
        case .figureGame:
            return "Лягушки и фигуры"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .speakAnimalGame:
            return UIImage(named: "notes")
        case .countGame:
            return UIImage(named: "many")
        case .colorGame:
            return UIImage(named: "colors")
        case .figureGame:
            return UIImage(named: "figures")
        }
    }
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

        GameSession.shared.numberOfCardsInSession = 6
        
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
            GameSession.shared.numberOfCardsInSession = 4
        }
    }
}
