//
//  FloatingPoint.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 28.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension FloatingPoint {
    /// Returns the opposite number.
    public var additiveInverse: Self {
        return self * -1
    }
    
    /// Returns the value to the power of `-1`.
    public var multiplicativeInverse: Self? {
        let zero: Self = 0
        guard self != zero else { return nil }
        
        return 1 / self
    }
}
