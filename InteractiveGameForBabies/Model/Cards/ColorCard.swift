//
//  ColorCard.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

struct ColorCard: CardProtocol {
    var imageName: String
    let color: Color
    
    func isEqualTo(_ object: Any) -> Bool {
        guard let other = object as? Self else { return false }
        return color == other.color
    }
}

enum Color  {
    case green
    case red
    case yellow
    case blue
    case pink
    case orange
    case grey
    case black
    case violet
}
