//
//  UITableViewCellTests.swift
//  TinySwift_Tests
//
//  Created by Piotr Sochalewski on 18.11.2017.
//  Copyright © 2017 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class UITableViewCellTests: XCTestCase {
    
    private var cell: UITableViewCell!
    
    override func setUp() {
        super.setUp()
        cell = UITableViewCell()
    }
    
    func testHideSeparator() {
        cell.hideSeparator()
        XCTAssert(cell.separatorInset.left == .infinity)
        XCTAssert(cell.indentationWidth == .infinity * -1.0)
        XCTAssert(cell.indentationLevel == 1)
    }
}
