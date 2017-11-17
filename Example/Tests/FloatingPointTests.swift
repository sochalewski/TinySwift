//
//  FloatingPointTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 28.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class FloatingPointTests: XCTestCase {
    
    private let zero = 0.0
    private let five = 5.0
    private let minusFive = -5.0
    
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
    
    func testAngles() {
        let fiveDegToRad = five.degreesToRadians
        XCTAssertEqual(fiveDegToRad, 0.087, accuracy: 0.01)
        XCTAssert(fiveDegToRad.radiansToDegrees == five)
    }
}
