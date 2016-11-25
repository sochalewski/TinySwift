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
    #if !os(watchOS)
    /// Shuffles the objects in the dictionary. The objects in the dictionary are shuffled based on a Fisher-Yates shuffle.
    @available(iOS 9.0, tvOS 9.0, *)
    public mutating func shuffle() {
        let shuffledKeys = Array(keys).shuffled
        let shuffledValues = Array(values).shuffled
        
        var dictionary = [Key : Value]()
        
        for (key, value) in zip(shuffledKeys, shuffledValues) {
            dictionary[key] = value
        }
        
        self = dictionary
    }
    
    /// Returns a shuffled instance of the dictionary. The objects in the dictionary are shuffled based on a Fisher-Yates shuffle.
    @available(iOS 9.0, tvOS 9.0, *)
    public var shuffled: [Key : Value] {
        var dictionary = self
        dictionary.shuffle()
        
        return dictionary
    }
    #endif
    
    /// Returns a randomized key and value pair from the dictionary.
    public var random: [Key : Value]? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        
        return [Array(keys)[index] : Array(values)[index]]
    }
}
