//
//  CountCard.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

class CountCard: CardProtocol {
    var imageName: String
    let count: Count
    
    init (imageName : String, count: Count) {
        self.imageName = imageName
        self.count = count
    }
    
    enum Count  {
        case one
        case many
    }
    
}
