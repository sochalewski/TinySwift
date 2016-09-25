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

    func testArrayRandomElement() {
        let array = [1, 2, 3, 4, 5]
        XCTAssert(array.contains(array.random!), "Array does not contain randomized element")
    }
    
    func testAreAllArrayElementsEqual() {
        let equalArray = [1, 1, 1, 1, 1]
        let nonEqualArray = [1, 1, 1, 1, 0]
        XCTAssert(equalArray.areAllElementsEqual, "False negative result on Array.areAllElementsEqual()")
        XCTAssert(!nonEqualArray.areAllElementsEqual, "False positive result on Array.areAllElementsEqual()")
    }
    
    func testArraySafeSubscript() {
        var fiveElements = Array(repeating: 0, count: 5)
        XCTAssertNil(fiveElements[safe: fiveElements.count], "Element out of bounds got with safe: subscript should be optional/nil and not cause a crash")
        XCTAssertNotNil(fiveElements[safe: fiveElements.count - 1], "Element from bounds got with safe: subscript should exist")
        fiveElements[safe: 2] = 5
        XCTAssert(fiveElements[safe: 2] == 5, "Elements should be able to change through the safe: subscript accessor")
    }
}
