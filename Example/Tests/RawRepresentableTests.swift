//
//  RawRepresentableTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

enum Suit: String {
    case spades = "♠"
    case hearts = "♥"
    case diamonds = "♦"
    case clubs = "♣"
}

class RawRepresentableTests: XCTestCase {
    
    func testCases() {
        let cases = Suit.all
        
        XCTAssert(cases.count == 4)
        XCTAssert(cases.contains(.spades) && cases.contains(.hearts) && cases.contains(.diamonds) && cases.contains(.clubs))
    }
}
