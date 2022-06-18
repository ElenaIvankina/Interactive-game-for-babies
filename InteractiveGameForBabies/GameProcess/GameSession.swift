//
//  GameSession.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

protocol GameSessionProtocol: AnyObject {
    
    var questionsArray: [QuestionProtocol] {get set}
    var cardsArray: [CardProtocol] {get set}
    var currentQuestion: QuestionProtocol? {get}
    var currentRandomCards: [CardProtocol] {get}
    var numberOfRightAnswers: Int {get}
    var counterOfRightAnswers: Observable<Int> {get set}
    
}

class GameSession: GameSessionProtocol {
    
    var questionsArray: [QuestionProtocol] = []
    var cardsArray: [CardProtocol] = []
    
    var currentQuestion: QuestionProtocol? {
        return questionsArray.randomElement()
        //надо обрабатывать опционал
    }
    
    var currentRandomCards: [CardProtocol] {
        return []
        //cardsArray.randomElements(sample: currentQuestion.card, countElements: 6)
        //надо забрать расширение для массива
    }

    var numberOfRightAnswers: Int {
        return 0
        //countRightAnswers(sample: currentQuestion.card, cards: currentRandomCards)
    }
    
    var counterOfRightAnswers: Observable<Int> = Observable(0)
    
    private func countRightAnswers(sample: CardProtocol, cards: [CardProtocol]) -> Int {
        
//        var counter = 0
        
//        for i in 0...cards.count-1 {
//           if cards[i] == sample {
//                //нужно забрать сравнение элементов CardProtocol
//                counter += 1
//            }
//        }
        
        return 2
        
    }

}
