//
//  GameViewControllerBuilder.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import UIKit

class GameViewControllerBuilder {
    
    static func buildGameSession(typeOfGame: TypeOfGame) -> GameSessionProtocol {
        let gameSession = GameSession()
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: typeOfGame)
        gameSession.currentQuestion = gameSession.getRandomQuestion(questionsArray: gameSession.questionsArray)
        gameSession.currentRandomCards = gameSession.getRandomCards(cardsArray: gameSession.cardsArray)
        gameSession.numberOfRightAnswers = gameSession.countRightAnswers(
            sample: gameSession.currentQuestion.card,
            cards: gameSession.currentRandomCards)
        return gameSession
    }
    
    static func buildAnimalGame() -> GameViewController {
        
        let gameSession = buildGameSession(typeOfGame: .speakAnimalGame)
        let gameDelegate = GameDelegate()
        let vc = GameViewController(gameSession: gameSession, gameDelegate: gameDelegate, typeOfGame: .speakAnimalGame, type: .sound)
        gameDelegate.gameViewcontroller = vc
        return vc
        
    }
    
    static func buildColorGame() -> GameViewController {
        
        let gameSession = buildGameSession(typeOfGame: .colorGame)
        let gameDelegate = GameDelegate()
        let vc = GameViewController(gameSession: gameSession, gameDelegate: gameDelegate, typeOfGame: .colorGame, type: .image)
        gameDelegate.gameViewcontroller = vc
        return vc
        
    }
    
    static func buildCountGame() -> GameViewController {
        
        let gameSession = buildGameSession(typeOfGame: .countGame)
        let gameDelegate = GameDelegate()
        let vc = GameViewController(gameSession: gameSession, gameDelegate: gameDelegate, typeOfGame: .countGame, type: .image)
        gameDelegate.gameViewcontroller = vc
        return vc
        
    }
    
    static func buildFigureGame() -> GameViewController {
        let gameSession = buildGameSession(typeOfGame: .figureGame)
        let gameDelegate = GameDelegate()
        let vc = GameViewController(gameSession: gameSession, gameDelegate: gameDelegate, typeOfGame: .figureGame, type: .text)
        gameDelegate.gameViewcontroller = vc
        return vc
        
    }
    
}
