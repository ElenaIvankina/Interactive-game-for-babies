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
}

extension ColorCard: Equatable {
    static func ==(lhs: ColorCard, rhs: ColorCard) -> Bool {
        return lhs.color == rhs.color
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
