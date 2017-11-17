//
//  CGAffineTransformTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 10.02.2017.
//  Copyright © 2017 Piotr Sochalewski. All rights reserved.
//

import XCTest

class CGAffineTransformTests: XCTestCase {
    
    private var view: UIView!
    
    override func setUp() {
        super.setUp()
        view = UIView()
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
    }
    
    func testGetScale() {
        view.transform = CGAffineTransform(scaleX: 2.0, y: 3.0)
        XCTAssert(view.transform.scaleX == 2.0)
        XCTAssert(view.transform.scaleY == 3.0)
    }
    
    func testGetRotation() {
        view.transform = CGAffineTransform(rotationAngle: 3.0)
        XCTAssert(view.transform.rotationAngle == 3.0)
    }
}
