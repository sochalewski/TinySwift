//
//  UIColorTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 26.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class UIColorTests: XCTestCase {
    
    private let black = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    private let white = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    private let transparentWhite = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
    
    func testHexInit() {
        XCTAssert(UIColor(hex: "#000", alpha: 1.0) == black, "Three signs hex with hash should return proper color")
        XCTAssert(UIColor(hex: "000f") == black, "Four signs hex without hash should return proper color")
        XCTAssert(UIColor(hex: "000000", alpha: 1.0) == black, "Six signs hex without hash should return proper color")
        XCTAssert(UIColor(hex: "#000000ff") == black, "Eight signs hex without hash should return proper color")
        XCTAssertNil(UIColor(hex: "#MKL666"), "Wrong hex should return nil")
        XCTAssertNil(UIColor(hex: "#0000000000"), "Wrong hex code length should return nil")
    }
    
    func testHex() {
        XCTAssert(black.hex == "#000000", "Wrong hex for black color")
        XCTAssert(white.hex == "#FFFFFF", "Wrong hex for white color")
        XCTAssert(transparentWhite.hex == "#FFFFFF00", "Wrong hex for transparent white color")
    }
}
