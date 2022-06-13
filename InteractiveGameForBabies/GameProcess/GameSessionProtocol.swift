//
//  GameSessionProtocol.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

protocol GameSessionProtocol {
    var question: QuestionProtocol {get set}
    var randomCards: [CardProtocol] {get set}
    var rightAnswers: [CardProtocol] {get set}
    
}
