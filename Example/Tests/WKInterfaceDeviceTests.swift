//
//  WKInterfaceDeviceTests.swift
//  TinySwift_Tests
//
//  Created by Piotr Sochalewski on 17.11.2017.
//  Copyright © 2017 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class WKInterfaceDeviceTests: XCTestCase {
    
    private let allTypes = WatchDeviceType.allCases

    func testEquatable() {
        allTypes.forEach {
            XCTAssert($0 == $0)
            XCTAssert($0 != WatchDeviceType(rawValue: $0.rawValue + 1) ?? .unknown)
        }
    }
    
    func testComparable() {
        allTypes.forEach {
            guard let biggerWatch = WatchDeviceType(rawValue: $0.rawValue + 1) else { return }
            XCTAssert($0 < biggerWatch)
        }
    }
}
