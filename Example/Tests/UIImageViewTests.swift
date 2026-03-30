//
//  UIImageViewTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 06.05.2017.
//  Copyright © 2017 Piotr Sochalewski. All rights reserved.
//

import UIKit
import XCTest
import TinySwift

class UIImageViewTests: XCTestCase {

    #if SWIFT_PACKAGE
    private let resourceBundle = Bundle.module
    #else
    private let resourceBundle = Bundle(for: UIImageViewTests.self)
    #endif
    
    private lazy var image = UIImage(named: "land.jpg", in: resourceBundle, compatibleWith: nil)
    private let url = URL(string: "https://httpbin.org/image/jpeg")!
    
    func testImageFromURL() {
        let expectation = self.expectation(description: "Image should be downloaded")
        
        let imageView = UIImageView()
        imageView.setImage(from: url, placeholder: image) { success in
            guard success else { return }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0)
    }
    
    func testSharpenForQRCode() {
        let imageView = UIImageView()
        
        imageView.sharpenForQRCode()
        
        XCTAssertEqual(imageView.layer.magnificationFilter, .nearest)
    }
}
