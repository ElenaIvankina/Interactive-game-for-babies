//
//  Array.swift
//  InteractiveGameForBabies
//
//  Created by Павел Черняев on 17.06.2022.
//

import Foundation

extension Array where Element == CardProtocol {
    
    func randomElements(sample: CardProtocol, countElements: Int) -> [Element] {
        var arr = [Element]()
        
        if (countElements < 1 || self.isEmpty) { return arr }
        
        //let countCorrectElements = Int.random(in: 1..<countElements)
        let countCorrectElements = Int.random(in: 1...3)
        arr = self
            .filter({ $0.isEqualTo(sample) })
            .shuffled()
            .suffix(countCorrectElements)
        
        let countOtherElements = countElements - arr.count
        
        arr = (arr + self
                .filter({ !$0.isEqualTo(sample) })
                .shuffled()
                .suffix(countOtherElements))
            .shuffled()
        
        return arr
    }
}
