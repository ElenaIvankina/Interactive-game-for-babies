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
    var numberOfCardsInSession: Int {get set}
    var currentQuestion: QuestionProtocol? {get}
    var currentRandomCards: [CardProtocol] {get}
    var numberOfRightAnswers: Int {get}
    var counterOfRightAnswers: Observable<Int> {get set}
    
}

class GameSession: GameSessionProtocol {
    
    var questionsArray: [QuestionProtocol] = []
    var cardsArray: [CardProtocol] = []
    
    var numberOfCardsInSession: Int = 6
    
    var currentQuestion: QuestionProtocol? {
        return questionsArray.randomElement()
    }
    
    var currentRandomCards: [CardProtocol] {
        if let currentQuestion: QuestionProtocol = currentQuestion {
            return cardsArray.randomElements(sample: currentQuestion.card,
                                             countElemens: numberOfCardsInSession)
        } else {
            return []
        }
    }

    var numberOfRightAnswers: Int {
        if let currentQuestion: QuestionProtocol = currentQuestion {
            return countRightAnswers(sample: currentQuestion.card, cards: currentRandomCards)
        } else {
            return 0
        }
    }
    
    var counterOfRightAnswers: Observable<Int> = Observable(0)
    
    private func countRightAnswers(sample: CardProtocol, cards: [CardProtocol]) -> Int {
        
        var counter = 0
        
        for i in 0...cards.count-1 {
           if cards[i].isEqualTo(sample) {
                counter += 1
            }
        }
        //неправильно считает, надо сравнение нормальное сделать
        return counter
    }

}
