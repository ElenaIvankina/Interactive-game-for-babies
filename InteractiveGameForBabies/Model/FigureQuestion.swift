//
//  FigureQuestion.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class FigureQuestion: QuestionProtocol {
    var card: CardProtocol
    var questionText: String
    
    init (countCard: FigureCard, questionText: String ) {
        self.card = countCard
        self.questionText = questionText
    }
}
