//
//  CardProtocol.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

protocol CardProtocol {
    var imageName: String {get set}
}

func ==(lhs: CardProtocol, rhs: CardProtocol) -> Bool {

    guard type(of: lhs) == type(of: rhs) else { return false }

    if let lhs = lhs as? AnimalCard, let rhs = rhs as? AnimalCard {
        return lhs.imageName == rhs.imageName
    }

    if let lhs = lhs as? ColorCard, let rhs = rhs as? ColorCard {
        return lhs.color == rhs.color
    }

    if let lhs = lhs as? CountCard, let rhs = rhs as? CountCard {
        return lhs.count == rhs.count
    }

    if let lhs = lhs as? FigureCard, let rhs = rhs as? FigureCard {
        return lhs.figure == rhs.figure
    }

    return false
}
