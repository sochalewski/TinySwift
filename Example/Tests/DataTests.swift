//
//  DataTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 09.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class DataTests: XCTestCase {
    
    let hexString = "54696e795377696674"
    let notHexString = "XYZ"
    
    var data: Data?
    var invalidData: Data?
    
    override func setUp() {
        super.setUp()
        
        data = Data(hexadecimalString: hexString)
        invalidData = Data(hexadecimalString: notHexString)
    }
    
    func testDataFromHex() {
        XCTAssertNotNil(data)
        XCTAssertNil(invalidData)
    }
    
    func testDataHexadecimalString() {
        XCTAssert(data?.hexadecimalString == hexString)
    }
}
