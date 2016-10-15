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

@testable import TinySwift_Example

class UIViewControllerTests: XCTestCase {
    
    let viewController = UIApplication.shared.keyWindow!.rootViewController!
    let title = "Title"
    let message = "Message"
    
    func testPresentAlertController() {
        let alertTitleExceptation = expectation(description: "Alert controller's title should be correct")
        let alertMessageExceptation = expectation(description: "Alert controller's message should be correct")
        
        viewController.presentAlertController(withTitle: title, message: message, completion: {
            guard let alertController = self.viewController.presentedViewController as? UIAlertController else { XCTFail("View controller should present alert controller after execute tested function"); return }
            
            if alertController.title == self.title {
                alertTitleExceptation.fulfill()
            }
            if alertController.message == self.message {
                alertMessageExceptation.fulfill()
            }
        })
        
        waitForExpectations(timeout: 5.0)
    }
}
