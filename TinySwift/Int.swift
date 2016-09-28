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
}
