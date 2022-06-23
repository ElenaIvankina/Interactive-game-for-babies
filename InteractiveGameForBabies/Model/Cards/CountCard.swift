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

    func isEqualTo(_ object: CardProtocol) -> Bool {
        guard let other = object as? Self else { return false }
        return count == other.count
    }
}

enum Count {
    case one
    case many
}
