//
//  Dictionary.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 16.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension Dictionary {
    /// Returns a randomized key and value pair from the dictionary.
    @available(swift, deprecated: 4.2, message: "Deprecated in favor of Collection.randomElement().")
    var random: [Key : Value]? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        
        return [Array(keys)[index] : Array(values)[index]]
    }
}
