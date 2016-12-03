//
//  BoolTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 03.12.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class BoolTests: XCTestCase {
    
    func testInit() {
        XCTAssertFalse(Bool(0))
        XCTAssertTrue(Bool(1))
        XCTAssertTrue(Bool(2))
        XCTAssertTrue(Bool(-1))
    }
    
    func testRandom() {
        let randoms = (0..<20).flatMap { _ in Bool.random }
        XCTAssert(!randoms.areAllElementsEqual)
    }
    
    func testToggle() {
        var bool = true
        
        bool.toggle()
        XCTAssertFalse(bool)
        
        bool.toggle()
        XCTAssertTrue(bool)
    }
}
