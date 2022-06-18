//
//  GameDelegate.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 17.06.2022.
//

import Foundation
import UIKit

class GameDelegate {
    
    var controller: UIViewController?
    
//      в контроллере добавить
//      gameSession.counterOfRightAnswers.addObserver(self, options: [.new], closure {
//      [weak self] number, _ in
//          if number == gameSession.numberOfRightAnswers {
//           self.makeGameEndAlert()
//          }
//      }
    
    func checkingAnswer(questionCard: CardProtocol, answerCard: CardProtocol) {
        //если равны запуск функции handlingRightAnswer()
        //если нет запуск функции handlingWrongAnswer()
        
    }
    
    func handlingRightAnswer() {
        //controller.gameSession.counterOfRightAnswers += 1
        //Анимация зеленым, ячейка уже неактивна для нажатия
    }
    
    func handlingWrongAnswer() {
        //Анимация красным, ячейка активна для нажатия
    }
    
//    func makeGameEndAlert() {
//        let alert = UIAlertController(title: "Молодец, малыш!",
//                                      message: "Сыграем еще?",
//                                      preferredStyle: .alert)
//         
//        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] _ in
//            guard let self = self else {return}
//            self.gameDelegate.newGame()
//        }))
//        
//        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { [weak self] _ in
//            guard let self = self else {return}
//            self.gameDelegate.endGame()
//        }))
//         
//        //self.present(alert, animated: true)
//        //эта функция должна быть в контроллере, в любом, мб в меню и он будет алертделегатом, чтобы в             каждой игре не дублировать
//    }
    
    func newGame() {
        
        //        let navigationVC = controller?.navigationController
        //        controller.gameSession = nil
        //        navigationVC.dismiss(animated: true)
        //        newVC = GameViewControllerBuilder.build...тип контроллера надо узнать как то (через as мб)
        //        navigationVC.push (newVC, animated: true)
    }
    
    func endGame() {
        //        controller.gameSession = nil
        //        controller?.navigationController?.dismiss(animated: true)
        
    }
    

    
    
}
