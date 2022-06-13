//
//  AnimalCard.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class AnimalCard: CardProtocol {
    var imageName: String
    
    init (imageName : String) {
        self.imageName = imageName
    }
}
