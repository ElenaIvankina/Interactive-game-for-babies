//
//  AnimalQuestion.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 18.06.2022.
//

import Foundation

struct AnimalQuestion: QuestionProtocol {
    var card: CardProtocol
    var questionText: String = "Какое животное так говорит?"

    init (card: AnimalCard) {
        self.card = card
    }
}
