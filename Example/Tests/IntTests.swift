//
//  IntTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class IntTests: XCTestCase {
    
    func testFactorial() {
        let usnignedInt: UInt = 5
        XCTAssert(usnignedInt.factorial == 120)
        
        let signedInt = 9
        XCTAssert(signedInt.factorial! == 362_880)
        
        let zero = 0
        XCTAssert(zero.factorial! == 1)
        
        let negativeInt = -1
        XCTAssertNil(negativeInt.factorial)
        
        let tooBigInt = 200
        XCTAssert(tooBigInt.factorial! == Double.infinity)
    }
    
    func testOdd() {
        XCTAssertTrue(5.isOdd)
        XCTAssertFalse(6.isOdd)
        XCTAssertFalse(0.isOdd)
        XCTAssertTrue((-5).isOdd)
        XCTAssertFalse((-6).isOdd)
    }
    
    func testEven() {
        XCTAssertFalse(5.isEven)
        XCTAssertTrue(6.isEven)
        XCTAssertTrue(0.isEven)
        XCTAssertFalse((-5).isEven)
        XCTAssertTrue((-6).isEven)
    }
    
    func testPrimeNumber() {
        XCTAssertTrue(2.isPrimeNumber)
        XCTAssertTrue(11.isPrimeNumber)
        XCTAssertTrue(863.isPrimeNumber)
        XCTAssertFalse(20.isPrimeNumber)
        XCTAssertFalse(0.isPrimeNumber)
        XCTAssertFalse(1.isPrimeNumber)
        XCTAssertFalse((-1).isPrimeNumber)
    }
    
    func testTimes() {
        var zero = 0
        5.times {
            zero += 1
        }
        XCTAssert(zero == 5)
        (-5).times {
            zero -= 1
        }
        XCTAssert(zero == 5)
    }
    
}
