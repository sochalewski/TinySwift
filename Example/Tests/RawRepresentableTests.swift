//
//  RawRepresentableTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

enum CardValue: Int {
    case ace = 11
    case ten = 10
    case king = 4
    case queen = 3
    case jack = 2
    case nine = 0
}

class RawRepresentableTests: XCTestCase {
    
    func testCases() {
        let cases = CardValue.all
        
        XCTAssert(cases.count == 6)
        XCTAssert(cases.first == .nine && cases.last == .ace)
    }
}
