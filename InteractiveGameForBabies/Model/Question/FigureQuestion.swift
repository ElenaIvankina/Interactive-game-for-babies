//
//  FigureQuestion.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

struct FigureQuestion: QuestionProtocol {
    var card: CardProtocol
    var questionText: String = "Нажми на фигуру, а затем на лягушку, которая держит макет для нее"
    let cardsFigure: [FigureCard]
    
    init (cardsFigure: [FigureCard]) {
        self.cardsFigure = cardsFigure
        self.card = FigureCard(imageName: "", figure: .emptyFigure)
    }
}
