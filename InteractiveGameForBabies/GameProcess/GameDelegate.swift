//
//  GameDelegate.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import UIKit

class GameWorker {

    func checkingAnswer(answerCard: CardProtocol) -> Bool {
        if GameSession.shared.currentQuestion.card.isEqualTo(answerCard) {
            handlingRightAnswer()
            return true
        } else {
            return false
        }
    }

    func handlingRightAnswer() {
        GameSession.shared.counterOfRightAnswers += 1
    }

    func newGame(viewController: GameViewController) {
        let gameVCBuilder = GameViewControllerBuilder()
        gameVCBuilder.buildNewGameSession(typeOfGame: viewController.typeOfGame)
        viewController.reloadData()
    }
}
