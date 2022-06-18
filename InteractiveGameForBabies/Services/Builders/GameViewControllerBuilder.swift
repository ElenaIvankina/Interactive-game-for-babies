//
//  GameViewControllerBuilder.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import UIKit

class GameViewControllerBuilder {
    
    static func buildAnimalGame() -> SpeakAnimalGameViewController {
        let vc = SpeakAnimalGameViewController()
        let gameDelegate = GameDelegate()
        let gameSession = GameSession()
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .speakAnimalGame)
        gameDelegate.controller = vc
//        vc.gameSession = gameSession
//        vc.gameDelegate = gameDelegate
//        надо в экранах эти свойства прописать
        
        return vc
        
    }
    
    static func buildColorGame() -> ColorGameViewController {
        let vc = ColorGameViewController()
        let gameDelegate = GameDelegate()
        let gameSession = GameSession()
        GameStrategy.setUpGameSession(gameSession: gameSession, typeOfGame: .colorGame)
        gameDelegate.controller = vc
//        vc.gameSession = gameSession
//        vc.gameDelegate = gameDelegate
//        надо в экранах эти свойства прописать
        
        return vc
        
    }
    
    static func buildCountGame() -> CountGameViewController {
        let vc = CountGameViewController(countQuestion: GameDatabase.shared.countQuestions[0])
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
    
    static func buildFigureGame() -> FigureGameViewController {
        let vc = FigureGameViewController()
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
