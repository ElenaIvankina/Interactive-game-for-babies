//
//  Array.swift
//  InteractiveGameForBabies
//
//  Created by Павел Черняев on 17.06.2022.
//

import Foundation

extension Array where Element: CardProtocol {
    
    func randomElements(sample: CardProtocol, countElemens: Int) -> [Element] {

        var arr = [Element]()
        
        if (countElemens < 1 || self.isEmpty) { return arr }
        
        let countCorrectElements = Int.random(in: 1..<countElemens)
        
        arr = self
            .filter({ $0 == sample })
            .shuffled()
            .suffix(countCorrectElements)
        
        let countOtherElements = countElemens - arr.count
        
        arr = (arr + self
            .filter({ $0 != sample })
            .shuffled()
            .suffix(countOtherElements))
            .shuffled()

        return arr
    }
}
