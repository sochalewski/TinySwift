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
    
    func testScreenSize() {
        XCTAssertTrue(UIScreen.main.size == .inch4p7, "Wrong screen size returned. Please check if you run the tests on iPhone 7 simulator (like Travis CI).")
        XCTAssertFalse(UIScreen.main.isSmallScreen, "Wrong screen size returned. Please check if you run the tests on iPhone 7 simulator (like Travis CI).")
    }
    
    func testComparable() {
        XCTAssert(ScreenSize.unknown < ScreenSize.inch3p5)
        XCTAssert(ScreenSize.inch3p5 < ScreenSize.inch4)
        XCTAssert(ScreenSize.inch4 < ScreenSize.inch4p7)
        XCTAssert(ScreenSize.inch4p7 < ScreenSize.inch5p5)
        XCTAssert(ScreenSize.inch5p5 < ScreenSize.inch5p8)
        XCTAssert(ScreenSize.inch5p8 < ScreenSize.inch7p9)
        XCTAssert(ScreenSize.inch7p9 < ScreenSize.inch9p7)
        XCTAssert(ScreenSize.inch9p7 < ScreenSize.inch12p9)
    }
}
