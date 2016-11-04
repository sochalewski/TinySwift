//
//  UIScreenTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 04.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class UIScreenTests: XCTestCase {
    
    func testScreenSize() {
        XCTAssertTrue(UIScreen.main.size == .inch4p7, "Wrong screen size returned. Please check if you run the tests on iPhone 7 simulator (like Travis CI).")
        XCTAssertFalse(UIScreen.main.isSmallScreen, "Wrong screen size returned. Please check if you run the tests on iPhone 7 simulator (like Travis CI).")
    }
}
