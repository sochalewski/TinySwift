//
//  RawRepresentableTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

private enum Card: Int {
    case ace = 11
    case ten = 10
    case king = 4
    case queen = 3
    case jack = 2
    case nine = 0
}

private enum Platform: String {
    case iOS = "iOS"
    case android = "Android"
}

class RawRepresentableTests: XCTestCase {
    
    func testCases() {
        let cardCases = Card.sortedAll
        XCTAssert(cardCases.count == 6)
        XCTAssert(cardCases.first == .nine && cardCases.last == .ace)
        
        let platformCases = Platform.all
        XCTAssert(platformCases.count == 2)
    }
}
