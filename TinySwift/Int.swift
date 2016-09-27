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
     
     Because of the output type limits, it does not work for number greater than 20.
     */
    public var factorial: UInt64? {
        guard self != 0 else { return 1 }
        guard 1...20 ~= self else { return nil }
        var integers = [UInt64]()
        for i in 1...toIntMax() {
            integers.append(UInt64(i))
        }
        
        return integers.reduce(1, *)
    }
}
