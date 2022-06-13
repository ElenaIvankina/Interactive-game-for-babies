//
//  CountQuestion.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class CountQuestion: QuestionProtocol {
    var card: CardProtocol
    var questionText: String
    
    init (countCard: CountCard, questionText: String ) {
        self.card = countCard
        self.questionText = questionText
    }
}
