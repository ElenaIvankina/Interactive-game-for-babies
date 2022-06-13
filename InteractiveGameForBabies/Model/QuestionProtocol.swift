//
//  QuestionProtocol.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

protocol QuestionProtocol {
    
    var card: CardProtocol {get set}
    var questionText: String {get set}

}
