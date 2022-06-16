//
//  AnimalCard.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

struct AnimalCard: CardProtocol {
    var imageName: String
}

extension AnimalCard: Equatable {
    static func ==(lhs: AnimalCard, rhs: AnimalCard) -> Bool {
        return lhs.imageName == rhs.imageName
    }
}
