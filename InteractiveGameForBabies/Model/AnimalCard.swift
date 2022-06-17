//
//  AnimalCard.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

struct AnimalCard: CardProtocol {
    var imageName: String
    let animal: Animal
    let sound: String
}

enum Animal {
    case cock
    case cat
    case elephant
    case fish
    case monkey
    case goat
    case mouse
    case dog
    case cuckoo
    case hedgehog
    case frog
    case cow
    case wolf
    case woodpecker
    case owl
    case bear
    case snake
    case parrot
    case camel
    case horse
    case donkey
}
