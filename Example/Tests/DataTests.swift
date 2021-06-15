//
//  DataTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 09.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class DataTests: XCTestCase {
    
    private let hexString = "54696e795377696674"
    private let notHexString = "XYZ"
    
    private var data: Data?
    private var invalidData: Data?
    
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
    
    func testQRCode() {
        let low = data?.qrCode(correctionLevel: .low)
        let medium = data?.qrCode(correctionLevel: .medium)
        let quartile = data?.qrCode(correctionLevel: .quartile)
        let high = data?.qrCode(correctionLevel: .high)
        let defaultParameter = data?.qrCode()
        
        XCTAssertEqual(low?.size, CGSize(width: 23, height: 23))
        XCTAssertEqual(medium?.size, CGSize(width: 23, height: 23))
        XCTAssertEqual(quartile?.size, CGSize(width: 23, height: 23))
        XCTAssertEqual(high?.size, CGSize(width: 27, height: 27))
        
        XCTAssertNotEqual(low?.pngData(), medium?.pngData())
        XCTAssertNotEqual(medium?.pngData(), quartile?.pngData())
        XCTAssertNotEqual(quartile?.pngData(), high?.pngData())
        XCTAssertNotEqual(high?.pngData(), low?.pngData())
        XCTAssertEqual(medium?.pngData(), defaultParameter?.pngData())
    }
}
