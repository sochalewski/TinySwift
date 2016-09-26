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
    
    func testInitialsString() {
        let name = "Piotr Sochalewski"
        let lorem = "Lorem ipsum dolor  \n    sit amet  "
        XCTAssert(name.initials == "PS", "Initials should return first letters")
        XCTAssert(lorem.initials == "Lidsa", "Initials should return first letters even if there are multiple spaces or new lines")
    }
    
    func testLinesString() {
        let lorem = ["Lorem ipsum", "dolor sit amet", "consectetur adipiscing elit"]
        let string = lorem.joined(separator: "\n")
        let lines = string.lines
        XCTAssert(lines == lorem, "Lines should equal the array that elements joined created the string")
    }
    
    func testNonEmptyLinesString() {
        let string = "Lorem ipsum\n  \t \ndolor sit amet\n \n  \n consectetur adipiscing elit\n  \n"
        XCTAssert(string.nonEmptyLines.count == 3, "Non empty lines should have three elements")
    }
}
