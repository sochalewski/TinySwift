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
}
