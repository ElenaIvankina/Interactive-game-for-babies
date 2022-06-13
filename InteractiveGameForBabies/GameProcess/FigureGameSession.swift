//
//  FigureGameSession.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class FigureGameSession: GameSessionProtocol {
    
    var question: QuestionProtocol = FigureQuestion (countCard: FigureCard(imageName: "", figure: .circle),
                                                     questionText: "Протяни цветные фигуры к их теням")
    
    var randomCards: [CardProtocol] = []
    
    var rightAnswers: [CardProtocol] = []
    
}
