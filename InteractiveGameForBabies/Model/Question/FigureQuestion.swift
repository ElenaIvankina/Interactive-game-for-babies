//
//  FigureQuestion.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

struct FigureQuestion: QuestionProtocol {
    var card: CardProtocol
    var questionText: String = "Выбери фигуру, а затем, удерживая её, протяни к лягушке, которая держит макет для неё"
    let cardsFigure: [FigureCard]
    
    init (cardsFigure: [FigureCard]) {
        self.cardsFigure = cardsFigure
        self.card = FigureCard(imageName: "", figure: .emptyFigure, imageNameFill: "")
    }
}
