//
//  UIViewControllerTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit
import XCTest
import TinySwift

class UIViewControllerTests: XCTestCase {
    
    let viewController = UIViewController()
    
    func testPresentAlertController() {
        XCTAssert(viewController.presentedViewController == nil, "View controller should not present any view controller before execute tested function")
        viewController.presentAlertController(withTitle: "Title", message: nil) {
            XCTAssert(self.viewController.presentedViewController != nil, "View controller should present alert view controller after execute tested function")
        }
    }
}
