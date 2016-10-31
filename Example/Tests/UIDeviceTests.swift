//
//  UIDeviceTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 31.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class UIDeviceTests: XCTestCase {
    
    func testDeviceType() {
        XCTAssertTrue(UIDevice.current.device == DeviceType.simulator)
    }
}
