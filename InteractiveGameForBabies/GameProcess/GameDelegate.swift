//
//  GameDelegate.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import UIKit

class GameDelegate {

    var gameViewController: GameViewControllerProtocol?

    func checkingAnswer(answerCard: CardProtocol) -> Bool {
        
        if GameSession.shared.currentQuestion.card.isEqualTo(answerCard) {
            handlingRightAnswer()
            return true
        } else {
            handlingWrongAnswer()
            return false
        }
    }

    func handlingRightAnswer() {
        
        GameSession.shared.counterOfRightAnswers.value += 1
        print("Right Answer")
        // Анимация зеленым, ячейка уже неактивна для нажатия
    }

    func handlingWrongAnswer() {
        print("Wrong Answer")
        // Анимация красным, ячейка активна для нажатия
    }

    func newGame() {
        let navigationVC = gameViewController?.navigationController
        let typeOfGame = gameViewController?.typeOfGame
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
            print("Не выбран тип игры")
        }

        if let newGameVC = newGameVC {
            navigationVC?.pushViewController(newGameVC, animated: true)
        }
    }

    func endGame() {
        gameViewController?.navigationController?.popToRootViewController(animated: true)
    }
}
