//
//  CountGameSession.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class CountGameSession: GameSessionProtocol {
    
    var question: QuestionProtocol = CountQuestion(countCard: CountCard(imageName: "", count: .one),
                                                   questionText: "Нажми на все картинки, где предмет один")
    
    var randomCards: [CardProtocol] = []
    
    var rightAnswers: [CardProtocol] = []

}
