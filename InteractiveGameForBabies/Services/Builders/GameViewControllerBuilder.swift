//
//  GameViewControllerBuilder.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import UIKit

class GameViewControllerBuilder {
    
    static func buildAnimalGame() -> GameViewController {
        
        let gameSession = GameSession()
        let gameDelegate = GameDelegate()
        let vc = GameViewController(gameSession: gameSession, gameDelegate: gameDelegate, typeOfGame: .speakAnimalGame, type: .sound)
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .speakAnimalGame)
        gameDelegate.gameViewcontroller = vc
        return vc
        
    }
    
    static func buildColorGame() -> GameViewController {
        
        let gameSession = GameSession()
        let gameDelegate = GameDelegate()
        let vc = GameViewController(gameSession: gameSession, gameDelegate: gameDelegate, typeOfGame: .colorGame, type: .image)
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .colorGame)
        gameDelegate.gameViewcontroller = vc
        return vc
        
    }
    
    static func buildCountGame() -> GameViewController {
        
        let gameSession = GameSession()
        let gameDelegate = GameDelegate()
        let vc = GameViewController(gameSession: gameSession, gameDelegate: gameDelegate, typeOfGame: .countGame, type: .image)
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .countGame)
        gameDelegate.gameViewcontroller = vc
        return vc
        
    }
    
    static func buildFigureGame() -> GameViewController {
        let gameSession = GameSession()
        let gameDelegate = GameDelegate()
        let vc = GameViewController(gameSession: gameSession, gameDelegate: gameDelegate, typeOfGame: .figureGame, type: .text)
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .figureGame)
        gameDelegate.gameViewcontroller = vc
        return vc
        
    }
    
}
