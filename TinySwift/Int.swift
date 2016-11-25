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
    public var isEven: Bool {
        return self % 2 == 0
    }
    
    /// A Boolean value that determines whether the value cannot be divided exactly by 2.
    public var isOdd: Bool {
        return self % 2 != 0
    }
    
    /// A Boolean value that determines whether the value is a natural number greater than 1 that has no positive divisors other than 1 and itself.
    public var isPrimeNumber: Bool {
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
    
    /// Returns the opposite number.
    public var additiveInverse: IntMax {
        return self.toIntMax() * -1.toIntMax()
    }
    
    /// Returns the value to the power of `-1`.
    public var multiplicativeInverse: Double? {
        guard self != 0 else { return nil }
        return 1.0 / Double(self.toIntMax())
    }
}

public extension SignedInteger {
    /// Returns the opposite number.
    public var additiveInverse: Self {
        return self * -1
    }
    
    /// Returns the time interval treating the value as a number of seconds.
    public var seconds: TimeInterval {
        return TimeInterval(self.toIntMax())
    }
    
    /// Returns the time interval treating the value as a number of minutes.
    public var minutes: TimeInterval {
        return seconds * 60.0
    }
    
    /// Returns the time interval treating the value as a number of hours.
    public var hours: TimeInterval {
        return minutes * 60.0
    }
    
    /// Returns the time interval treating the value as a number of days.
    public var days: TimeInterval {
        return hours * 24.0
    }
}

public extension Int {
    /**
     Initializes and returns a randomized integer value.
     
     - parameter range: A half-open interval over a comparable type, from a lower bound up to, but not including, an upper bound. You create Range instances by using the half-open range operator (`..<`). You may specify `nil` for this parameter if you want randomized value in the range of `-2^31` to `2^31`.
     - returns: A signed randomized integer value type.
     */
    public init(random range: Range<Int>? = nil) {
        if let range = range {
            self = Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
        } else {
            self = Int(arc4random()) + Int(Int32.min)
        }
    }
    
    /**
     Submits a block object for execution number or times defined by the value.

     - parameter block: The block to be invoked at least once. This parameter cannot be `NULL`.
     */
    public func times(execute block: @escaping () -> Void) {
        guard self > 0 else { return }
        (0..<self).forEach { _ in
            block()
        }
    }
}
