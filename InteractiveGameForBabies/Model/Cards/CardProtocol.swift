//
//  CardProtocol.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import Foundation

protocol CardProtocol {
    var imageName: String {get set}
    
    func isEqualTo(_ object: Any) -> Bool
}
