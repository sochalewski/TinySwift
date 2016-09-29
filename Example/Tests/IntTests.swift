//
//  IntTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class IntTests: XCTestCase {
    
    func testFactorial() {
        let usnignedInt: UInt = 5
        XCTAssert(usnignedInt.factorial == 120)
        
        let signedInt = 9
        XCTAssert(signedInt.factorial! == 362_880)
        
        let zero = 0
        XCTAssert(zero.factorial! == 1)
        
        let negativeInt = -1
        XCTAssertNil(negativeInt.factorial)
        
        let tooBigInt = 200
        XCTAssert(tooBigInt.factorial! == Double.infinity)
    }
    
    func testTest() {
        let array = [0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 5, 5, 7, 7, 7, 9] //0x5, 1x1, 2x4, 5x2, 7x3, 9x1
        array.mode
    }
}
