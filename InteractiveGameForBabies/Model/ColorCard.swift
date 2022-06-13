//
//  ColorCard.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class ColorCard: CardProtocol {
    var imageName: String
    let color: Color
    
    init (imageName : String, color: Color) {
        self.imageName = imageName
        self.color = color
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
    
}

