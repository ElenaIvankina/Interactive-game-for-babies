//
//  AnimalQuestion.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 18.06.2022.
//

import Foundation

class AnimalQuestion: QuestionProtocol {
    var card: CardProtocol
    var questionText: String
    
    init (card: AnimalCard, questionText: String ) {
        self.card = card
        self.questionText = questionText
    }
}
