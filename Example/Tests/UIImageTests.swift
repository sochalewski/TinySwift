//
//  UIImageTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 25.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit
import XCTest
import TinySwift

class UIImageTests: XCTestCase {
    
    let image = UIImage(named: "land.jpg", in: Bundle(for: UIImageTests.self), compatibleWith: nil)
    
    func testImageThumbnail() {
        guard let thumbnail = image?.thumbnail else { XCTFail("Cannot generate thumbnail"); return }
        XCTAssert(thumbnail.size.width == 300.0 || thumbnail.size.height == 300.0, "Thumbnail's width or height should equal 300 px")
    }
    
    func testImageJpeg() {
        guard let jpeg100 = image?.jpeg, let jpeg40 = image?.jpeg(quality: 0.4), let _ = image?.png else { XCTFail("Cannot generate compressed images"); return }
        XCTAssert(jpeg100.count > jpeg40.count, "Stronger compression should correspond with smaller size")
    }
    
    func testImageSquare() {
        guard let square = image?.square else { XCTFail("Cannot generate square image"); return }
        XCTAssert(square.size.height == square.size.width, "square() should return square image")
    }
    
    func testImageResize() {
        guard let resized = image?.resize(to: CGSize(width: 100.0, height: 100.0)) else { XCTFail("Cannot generate resized image"); return }
        XCTAssert(resized.size.width == 100.0 || resized.size.height == 100.0, "Resized image has wrong size")
    }
}
