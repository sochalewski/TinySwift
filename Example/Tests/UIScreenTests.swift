//
//  UIScreenTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 04.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class UIScreenTests: XCTestCase {
    
    private let allSizes = ScreenSize.allCases
    
    func testScreenSize() {
        XCTAssertTrue(UIScreen.main.size == .inch4p7, "Wrong screen size returned. Please check if you run the tests on iPhone 7 simulator (like Travis CI).")
        XCTAssertFalse(UIScreen.main.isSmallScreen, "Wrong screen size returned. Please check if you run the tests on iPhone 7 simulator (like Travis CI).")
    }
    
    func testEquatable() {
        allSizes.forEach {
            XCTAssert($0 == $0)
            XCTAssert($0 != ScreenSize(rawValue: $0.rawValue + 1) ?? .unknown)
        }
    }
    
    func testComparable() {
        allSizes.forEach {
            guard let biggerSize = ScreenSize(rawValue: $0.rawValue + 1) else { return }
            XCTAssert($0 < biggerSize)
        }
    }
}
