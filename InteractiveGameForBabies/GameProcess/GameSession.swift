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
    var currentQuestion: QuestionProtocol {get set}
    var currentRandomCards: [CardProtocol] {get}
    var numberOfRightAnswers: Int {get}
    var counterOfRightAnswers: Observable<Int> {get set}
    
}

class GameSession: GameSessionProtocol {
    
    var questionsArray: [QuestionProtocol] = []
    var cardsArray: [CardProtocol] = []
    
    var numberOfCardsInSession: Int = 6
    
    var currentQuestion: QuestionProtocol = AnimalQuestion(card: AnimalCard(imageName: "animal1", animal: .camel, sound: ""))
    
    var currentRandomCards: [CardProtocol] = []

    var numberOfRightAnswers: Int = 0
    //countRightAnswers(sample: currentQuestion.card, cards: currentRandomCards)
        
    
    
    var counterOfRightAnswers: Observable<Int> = Observable(0)
    
    func getRandomQuestion(questionsArray: [QuestionProtocol]) -> QuestionProtocol {
        if let randomQuestion = questionsArray.randomElement() {
            return randomQuestion
        } else {
            return AnimalQuestion(card: AnimalCard(imageName: "animal1", animal: .camel, sound: ""))
        }
    }
    
   func getRandomCards(cardsArray: [CardProtocol]) -> [CardProtocol] {
       return cardsArray.randomElements(sample: currentQuestion.card,
                                                countElemens: numberOfCardsInSession)
    }
    
    func countRightAnswers(sample: CardProtocol, cards: [CardProtocol]) -> Int {
        
        var counter = 0
        
        for i in 0..<cards.count {
           if cards[i].isEqualTo(sample) {
                counter += 1
            }
        }
        return counter
    }

}
