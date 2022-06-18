//
//  GameViewControllerBuilder.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import UIKit

class GameViewControllerBuilder {
    
    static func buildAnimalGame() -> GameViewController {
        let vc = GameViewController(type: .sound)
        let gameDelegate = GameDelegate()
        let gameSession = GameSession()
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .speakAnimalGame)
        gameDelegate.controller = vc
//        vc.gameSession = gameSession
//        vc.gameDelegate = gameDelegate
//        надо в экранах эти свойства прописать
        
        return vc
        
    }
    
    static func buildColorGame() -> GameViewController {
        let vc = GameViewController(type: .image)
        let gameDelegate = GameDelegate()
        let gameSession = GameSession()
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .colorGame)
        gameDelegate.controller = vc
//        vc.gameSession = gameSession
//        vc.gameDelegate = gameDelegate
//        надо в экранах эти свойства прописать
        
        return vc
        
    }
    
    static func buildCountGame() -> GameViewController {
        let vc = GameViewController(type: .image)
        //countQuestion уйдет, инициализация единая будет у контроллеров игры
        let gameDelegate = GameDelegate()
        let gameSession = GameSession()
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .countGame)
        gameDelegate.controller = vc
//        vc.gameSession = gameSession
//        vc.gameDelegate = gameDelegate
//        надо в экранах эти свойства прописать
        
        return vc
        
    }
    
    static func buildFigureGame() -> GameViewController {
        let vc = GameViewController(type: .text)
        let gameDelegate = GameDelegate()
        let gameSession = GameSession()
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .figureGame)
        gameDelegate.controller = vc
//        vc.gameSession = gameSession
//        vc.gameDelegate = gameDelegate
//        надо в экранах эти свойства прописать
        
        return vc
        
    }
    
}
