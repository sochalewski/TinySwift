//
//  Int.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation
#if !os(watchOS)
    import GameplayKit
#endif

public extension BinaryInteger {
    /**
     Returns the product of all positive integers less than or equal to the integer.
     
     Because of the output type limitation, *n! = ∞* where *n* greater than *170*.
     */
    public var factorial: Double? {
        guard self != 0 else { return 1 }
        guard self > 0 else { return nil }
        var integers = [Double]()
        for i in 2...Int64(self) {
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
    public var isPrime: Bool {
        guard self > 1 else { return false }
        var divisor: Self = 2
        while divisor <= self / 2 {
            if self % divisor == 0 {
                return false
            } else {
                divisor = divisor + 1
            }
        }
        
        return true
    }
    
    /// Returns the opposite number.
    public var additiveInverse: Int64 {
        return Int64(self) * -1
    }
    
    /// Returns the value to the power of `-1`.
    public var multiplicativeInverse: Double? {
        guard self != 0 else { return nil }
        return 1.0 / Double(Int64(self))
    }
    
    /// Converts an angle measured in degrees to radians.
    public var degreesToRadians: Double {
        return Double(Int64(self)) * .pi / 180.0
    }
    
    /// Converts an angle measured in radians to degrees.
    public var radiansToDegrees: Double {
        return Double(Int64(self)) * 180.0 / .pi
    }
    
    /// Returns the time interval treating the value as a number of seconds.
    public var seconds: TimeInterval {
        return TimeInterval(Int64(self))
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
    /// Generates and returns a new random integer value in the range `[INT32_MIN, INT32_MAX]`.
    public static var random: Int {
        if #available(iOS 9.0, macOS 10.11, *) {
            #if !os(watchOS)
                return GKRandomSource.sharedRandom().nextInt()
            #else
                return Int(arc4random()) - Int(INT32_MAX)
            #endif
        } else {
            return Int(arc4random()) - Int(INT32_MAX)
        }
    }
    
    /**
     Generates and returns a new random integer less than the specified limit.
     - parameter upperBound: A limit on the values of random numbers to generate.
     - returns: A new random integer greater than or equal to zero and less than the value of the `upperBound` parameter.
     */
    public init(random upperBound: Int) {
        if #available(iOS 9.0, macOS 10.11, *) {
            #if !os(watchOS)
                self = GKRandomSource.sharedRandom().nextInt(upperBound: upperBound)
            #else
                self = Int(arc4random_uniform(UInt32(upperBound)))
            #endif
        } else {
            self = Int(arc4random_uniform(UInt32(upperBound)))
        }
    }
    
    /**
     Generates and returns a new random integer greater than or equal to the lower limit and less than the upper limit.

     - parameter range: A half-open interval over a comparable type, from a lower bound up to, but not including, an upper bound.
     - returns: A new random integer value in the given range.
     */
    public init(random range: Range<Int>) {
        self = range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    /**
     Generates and returns a new random integer greater than or equal to the lower limit and less than or equal to the upper limit.
     
     - parameter range: An interval over a comparable type, from a lower bound up to, and including, an upper bound.
     - returns: A new random integer value in the given range.
     */
    public init(random range: ClosedRange<Int>) {
        self = range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound) + 1))
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
