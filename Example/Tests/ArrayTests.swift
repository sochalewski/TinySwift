//
//  ArrayTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class ArrayTests: XCTestCase {

    func testRandomElement() {
        let array = [1, 2, 3, 4, 5]
        XCTAssert(array.contains(array.random!), "Array does not contain randomized element")
    }
    
    func testAreAllElementsEqual() {
        let equalArray = [1, 1, 1, 1, 1]
        let nonEqualArray = [1, 1, 1, 1, 0]
        XCTAssert(equalArray.areAllElementsEqual, "False negative result on Array.areAllElementsEqual()")
        XCTAssert(!nonEqualArray.areAllElementsEqual, "False positive result on Array.areAllElementsEqual()")
    }
    
    func testSafeSubscript() {
        var fiveElements = Array(repeating: 0, count: 5)
        XCTAssertNil(fiveElements[safe: fiveElements.count], "Element out of bounds got with safe: subscript should be optional/nil and not cause a crash")
        XCTAssertNotNil(fiveElements[safe: fiveElements.count - 1], "Element from bounds got with safe: subscript should exist")
        fiveElements[safe: 2] = 5
        XCTAssert(fiveElements[safe: 2] == 5, "Elements should be able to change through the safe: subscript accessor")
    }
    
    func testFloatSum() {
        let array = [1.2, 2.7, 3.2, 4.0, 5.1, 6.9]
        XCTAssert(array.sum == array.reduce(0, +))
    }
    
    func testIntSum() {
        let array = [1, 2, 3, 4, 5, 6]
        XCTAssert(array.sum == array.reduce(0, +))
    }
    
    func testFloatAverage() {
        let array = [1.2, 2.7, 3.2, 4.0, 5.1, 6.9]
        XCTAssert(array.average == array.reduce(0, +) / Double(array.count))
    }
    
    func testIntAverage() {
        let array = [1, 2, 3, 4, 5, 6]
        XCTAssert(array.average == Double(array.reduce(0, +)) / Double(array.count))
    }
}
