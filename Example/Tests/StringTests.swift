//
//  ArrayTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class Tests: XCTestCase {
    
    func testRandomString() {
        let desiredLength = 12
        let randomString = String(randomAlphanumericWithLength: desiredLength)
        XCTAssert(randomString.characters.count == desiredLength, "Randomized string length is not desired length")
        XCTAssert(!randomString.trimmed.isEmpty, "Randomized string contains only whitespaces")
    }
    
    func testTrimmedString() {
        let stringToBeTrimmed = "\n\n  XX \n \r \t "
        XCTAssert(stringToBeTrimmed.trimmed.characters.count == 2, "Trimmed string length is not desired length")
    }
}
