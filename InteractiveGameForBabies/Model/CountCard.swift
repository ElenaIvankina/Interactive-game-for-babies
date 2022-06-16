//
//  CountCard.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

struct CountCard: CardProtocol {
    var imageName: String
    let count: Count
}

extension CountCard: Equatable {
    static func ==(lhs: CountCard, rhs: CountCard) -> Bool {
        return lhs.count == rhs.count
    }
}

enum Count  {
    case one
    case many
}
