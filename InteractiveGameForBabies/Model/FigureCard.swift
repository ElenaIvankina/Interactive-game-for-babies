//
//  FigureCard.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

struct FigureCard: CardProtocol {
    var imageName: String
    let figure: Figure
}

enum Figure {
    case trapezoid
    case semicircle
    case parallelogram
    case nineangle
    case star
    case triangle
    case diamond
    case heart
    case square
    case rectangle
    case circle
    case oval
    case fiveangle
    case sixangle
    case sevenangle
    case eightangle
}
