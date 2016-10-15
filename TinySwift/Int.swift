//
//  Int.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension Integer {
    /**
     Returns the product of all positive integers less than or equal to the integer.
     
     Because of the output type limitation, *n! = ∞* where *n* greater than *170*.
     */
    public var factorial: Double? {
        guard self != 0 else { return 1 }
        guard self > 0 else { return nil }
        var integers = [Double]()
        for i in 2...toIntMax() {
            integers.append(Double(i))
        }
        
        return integers.reduce(1, *)
    }
    
    /// A Boolean value that determines whether the value can be divided exactly by 2.
    var isEven: Bool {
        return self % 2 == 0
    }
    
    /// A Boolean value that determines whether the value cannot be divided exactly by 2.
    var isOdd: Bool {
        return self % 2 != 0
    }
    
    /// A Boolean value that determines whether the value is a natural number greater than 1 that has no positive divisors other than 1 and itself.
    var isPrimeNumber: Bool {
        guard self > 1 else { return false }
        var divisor: Self = 2
        while divisor < self / 2 {
            if self % divisor == 0 {
                return false
            } else {
                divisor = divisor + 1
            }
        }
        
        return true
    }
}

public extension Int {
    /**
     Submits a block object for execution number or times defined by the value.

     - parameter block: The block to be invoked at least once. This parameter cannot be `NULL`.
     */
    func times(execute block: @escaping () -> Void) {
        guard self > 0 else { return }
        (0..<self).forEach { _ in
            block()
        }
    }
}
