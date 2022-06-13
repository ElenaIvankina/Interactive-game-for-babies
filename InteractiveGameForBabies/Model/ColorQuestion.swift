//
//  Question.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class ColorQuestion: QuestionProtocol {
    var card: CardProtocol
    var questionText: String
    
    init (colorCard: ColorCard, questionText: String ) {
        self.card = colorCard
        self.questionText = questionText
    }
}
