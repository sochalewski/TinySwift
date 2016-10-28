//
//  FloatingPointTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 28.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class FloatingPointTests: XCTestCase {
    
    let zero = 0.0
    let five = 5.0
    let minusFive = -5.0
    
    func testAdditiveInverse() {
        XCTAssertTrue(zero.additiveInverse == 0)
        XCTAssertTrue(five.additiveInverse == minusFive)
        XCTAssertTrue(minusFive.additiveInverse == five)
    }
    
    func testMultiplicativeInverse() {
        XCTAssertNil(zero.multiplicativeInverse)
        XCTAssertTrue(five.multiplicativeInverse == 0.2)
        XCTAssertTrue(minusFive.multiplicativeInverse == -0.2)
    }
}
