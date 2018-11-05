//
//  Bool.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 02.12.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation
#if !os(watchOS)
    import GameplayKit
#endif

public extension Bool {
    /**
     Creates an instance initialized to the specified integer value.
     - parameter integer: The integer value.
     */
    public init<T: BinaryInteger>(_ integer: T) {
        self = integer != 0
    }
    
    /// Generates and returns a new random Boolean value.
    @available(swift, deprecated: 4.2, message: "Deprecated in favor of Bool.random().")
    public static var random: Bool {
        #if !os(watchOS)
        if #available(iOS 9.0, tvOS 9.0, *) {
            return GKRandomSource.sharedRandom().nextBool()
        }
        #endif

        return arc4random_uniform(2) == 0
    }
    
    /**
     Performs a logical NOT operation on a Boolean value.
     
     The logical NOT operator (`!`) inverts a Boolean value. If the value is `true`, the result of the operation is `false`; if the value is `false`, the result is `true`.
     
         var bool = true
         bool.toggle()
         print(bool)
         // Prints false
     */
    @available(swift, obsoleted: 4.2)
    public mutating func toggle() {
        self = !self
    }
}
