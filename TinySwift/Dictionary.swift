//
//  Dictionary.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 16.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation
#if !os(watchOS)
    import GameplayKit
#endif

public extension Dictionary {
    /// Returns a randomized key and value pair from the dictionary.
    public var random: [Key : Value]? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        
        return [Array(keys)[index] : Array(values)[index]]
    }
}
