//
//  ObservableOptions.swift
//  InteractiveGameForBabies
//
//  Created by Елена Иванкина on 13.06.2022.
//

import UIKit

public struct ObservableOptions: OptionSet, CustomStringConvertible {

    public static let initial = ObservableOptions(rawValue: 1 << 0)
    public static let old = ObservableOptions(rawValue: 1 << 1)
    public static let new = ObservableOptions(rawValue: 1 << 2)

    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public var description: String {
        switch self {
        case .initial:
            return "initial"
        case .old:
            return "old"
        case .new:
            return "new"
        default:
            return "ObservableOption(rawValue: \(rawValue)"
        }
    }

}
