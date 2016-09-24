//
//  Array.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension Array {
    /// Returns a randomized array element.
    public var random: Element? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}

public extension Array where Element: Equatable {
    /// A Boolean value that determines whether all elements of the array are equal.
    public var areAllElementsEqual: Bool {
        guard let first = first else { return true }
        return !dropFirst().contains { $0 != first }
    }
}
