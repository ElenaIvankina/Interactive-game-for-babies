//
//  ColorGameSession.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class ColorGameSession: GameSessionProtocol {
    
    var question: QuestionProtocol = ColorQuestion(card: ColorCard(imageName: "", color: .green),
                                                   questionText: "Нажми на все предметы зеленого цвета")
    
    var randomCards: [CardProtocol] = []
    
    var rightAnswers: [CardProtocol] = []

}
