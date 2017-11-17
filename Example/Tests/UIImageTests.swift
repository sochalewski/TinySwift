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
    
    private let image = UIImage(named: "land.jpg", in: Bundle(for: UIImageTests.self), compatibleWith: nil)
    
    func testColorInit() {
        let color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let size = CGSize(width: 12.0, height: 24.0)
        guard let image = UIImage(color: color, size: size) else { XCTFail("Cannot init image"); return }
        XCTAssert(image.color(at: CGPoint(x: 0.0, y: 0.0)) == color, "Created image has wrong color")
        XCTAssert(image.size == size, "Created image has wrong size")
    }
    
    func testThumbnail() {
        guard let thumbnail = image?.thumbnail else { XCTFail("Cannot generate thumbnail"); return }
        XCTAssert(thumbnail.size.width == 300.0 || thumbnail.size.height == 300.0, "Thumbnail's width or height should equal 300 px")
    }
    
    func testJpeg() {
        guard let jpeg100 = image?.jpeg(), let jpeg40 = image?.jpeg(quality: 0.4), let _ = image?.png else { XCTFail("Cannot generate compressed images"); return }
        XCTAssert(jpeg100.count > jpeg40.count, "Stronger compression should correspond with smaller size")
    }
    
    func testSquare() {
        guard let square = image?.square else { XCTFail("Cannot generate square image"); return }
        XCTAssert(square.size.height == square.size.width, "square() should return square image")
    }
    
    func testResize() {
        guard let resized = image?.resize(to: CGSize(width: 100.0, height: 100.0)) else { XCTFail("Cannot generate resized image"); return }
        XCTAssert(resized.size.width == 100.0 || resized.size.height == 100.0, "Resized image has wrong size")
    }
    
    func testBorderAndColorAtPoint() {
        let whiteColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) // .white is UIExtendedGrayColorSpace and cannot be compared with UIImage.color(atPoint:) returning UIExtendedSRGBColorSpace
        
        guard let bordered = image?.border(width: 2.0, color: whiteColor) else { XCTFail("Cannot generate bordered image"); return }
        guard let borderedColorAtZeroZero = bordered.color(at: CGPoint(x: 0.0, y: 0.0)) else { XCTFail("Cannot get color at point"); return }
        XCTAssert(borderedColorAtZeroZero == whiteColor, "Border has wrong color/width OR color(atPoint:) returns wrong value")
    }
    
    func testGrayscale() {
        XCTAssertNotNil(image?.grayscale, "Cannot generate grayscale image")
    }
}
