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
            return false
        }
    }

    func handlingRightAnswer() {
        
        GameSession.shared.counterOfRightAnswers.value += 1
    }

    func newGame() {
        
        guard let vc = gameViewController as? GameViewController else {return}
        let gameVCBuilder = GameViewControllerBuilder()
        gameVCBuilder.buildNewGameSession(typeOfGame: vc.typeOfGame)
        vc.answersViewController.gameAnswersView.collectionView.reloadData()
        vc.questionViewController.reloadData()
        
        
        
//        let navigationVC = gameViewController?.navigationController
//        guard let typeOfGame = gameViewController?.typeOfGame else { return }
//        var newGameVC: GameViewControllerProtocol?
//        let gameVCBuilder = GameViewControllerBuilder()
//        newGameVC = gameVCBuilder.buildGame(typeOfGame: typeOfGame)
//
//        if let newGameVC = newGameVC {
//            navigationVC?.pushViewController(newGameVC, animated: true)
//        }
    }

    func endGame() {
        gameViewController?.navigationController?.popToRootViewController(animated: true)
    }
}
