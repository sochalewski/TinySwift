//
//  URLTests.swift
//  TinySwift_Tests
//
//  Created by Piotr Sochalewski on 15/06/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import TinySwift

class URLTests: XCTestCase {
    
    func testQRCode() {
        let url = URL(string: "https://en.wikipedia.org/wiki/QR_code")!
        
        let low = url.qrCode(correctionLevel: .low)
        let medium = url.qrCode(correctionLevel: .medium)
        let quartile = url.qrCode(correctionLevel: .quartile)
        let high = url.qrCode(correctionLevel: .high)
        let defaultParameter = url.qrCode()
        
        XCTAssertEqual(low?.size, CGSize(width: 31, height: 31))
        XCTAssertEqual(medium?.size, CGSize(width: 31, height: 31))
        XCTAssertEqual(quartile?.size, CGSize(width: 35, height: 35))
        XCTAssertEqual(high?.size, CGSize(width: 39, height: 39))
        
        XCTAssertNotEqual(low?.pngData(), medium?.pngData())
        XCTAssertNotEqual(medium?.pngData(), quartile?.pngData())
        XCTAssertNotEqual(quartile?.pngData(), high?.pngData())
        XCTAssertNotEqual(high?.pngData(), low?.pngData())
        XCTAssertEqual(medium?.pngData(), defaultParameter?.pngData())
    }
}
