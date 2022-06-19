//
//  GameDelegate.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import Foundation
import UIKit

class GameDelegate {
    
    var gameViewcontroller: GameViewControllerProtocol?
        
    func checkingAnswer(answerCard: CardProtocol) {
        if let questionCard = gameViewcontroller?.gameSession.currentQuestion?.card,
           questionCard.isEqualTo(answerCard) {
            handlingRightAnswer()
        } else {
            handlingWrongAnswer()
        }
    }
    
    func handlingRightAnswer() {
        
        if let vc = gameViewcontroller {
            vc.gameSession.counterOfRightAnswers.value += 1
        }
        
        print ("Right Answer")
        //Анимация зеленым, ячейка уже неактивна для нажатия
        
    }
    
    func handlingWrongAnswer() {
        
        print ("Wrong Answer")
        //Анимация красным, ячейка активна для нажатия
        
    }
    
    func newGame() {
        
        let navigationVC = gameViewcontroller?.navigationController
        let typeOfGame = gameViewcontroller?.typeOfGame
        //gameViewcontroller?.gameSession = nil
        navigationVC?.dismiss(animated: true)
        var newGameVC: GameViewControllerProtocol?
        
        switch typeOfGame {
        case .speakAnimalGame:
            newGameVC = GameViewControllerBuilder.buildAnimalGame()
        case .colorGame:
            newGameVC = GameViewControllerBuilder.buildColorGame()
        case .countGame:
            newGameVC = GameViewControllerBuilder.buildCountGame()
        case .figureGame:
            newGameVC = GameViewControllerBuilder.buildFigureGame()
        case .none:
            print ("Не выбран тип игры")
        }
        
        if let newGameVC = newGameVC {
            navigationVC?.pushViewController(newGameVC, animated: true)
        }
        
    }
    
    func endGame() {
        
        //gameViewcontroller?.gameSession = nil
        gameViewcontroller?.navigationController?.dismiss(animated: true)
        
    }
    

    
    
}
