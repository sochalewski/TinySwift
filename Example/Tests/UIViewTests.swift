//
//  UIViewTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 19.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class UIViewTests: XCTestCase {
    
    func testViewFromNib() {
        let sampleView = View(frame: .zero)
        XCTAssertNotNil(sampleView.view)
        XCTAssert(sampleView.subviews.count == 1)
        XCTAssert(sampleView.subviews.first?.subviews.count == 1)
    }
}
