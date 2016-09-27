//
//  IntTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class IntTests: XCTestCase {
    
    func testIntFactorial() {
        let usnignedInt: UInt = 5
        XCTAssert(usnignedInt.factorial == 120)
        
        let signedInt = 5
        XCTAssert(signedInt.factorial! == 120)
        
        let negativeInt = -1
        XCTAssertNil(negativeInt.factorial)
        
        let tooBigSignedInt = 30
        XCTAssertNil(tooBigSignedInt.factorial)
        
        let tooBigUnsignedInt: UInt = 30
        XCTAssertNil(tooBigUnsignedInt.factorial)
    }
}
