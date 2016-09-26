//
//  UIColorTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 26.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class UIColorTests: XCTestCase {
    
    func testHexColor() {
        XCTAssert(UIColor(hex: "000", alpha: 1.0) == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), "Three signs without hash")
        XCTAssert(UIColor(hex: "#000") == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), "Three signs with hash")
        XCTAssert(UIColor(hex: "000f") == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), "Four signs without hash")
        XCTAssert(UIColor(hex: "#000f", alpha: 1.0) == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), "Four signs with hash")
        XCTAssert(UIColor(hex: "000000", alpha: 1.0) == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), "Six signs without hash")
        XCTAssert(UIColor(hex: "#000000") == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), "Six signs with hash")
        XCTAssert(UIColor(hex: "000000ff") == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), "Eight signs without hash")
        XCTAssert(UIColor(hex: "#000000ff", alpha: 1.0) == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), "Eight signs with hash")
    }
}
