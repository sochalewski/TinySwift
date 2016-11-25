//
//  IntTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class IntTests: XCTestCase {
    
    let zero = 0
    let five = 5
    let minusFive = -5
    
    func testFactorial() {
        let usnignedInt: UInt = 5
        XCTAssert(usnignedInt.factorial == 120)
        
        let signedInt = 9
        XCTAssert(signedInt.factorial! == 362_880)
        
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
        five.times {
            zero += 1
        }
        XCTAssert(zero == five)
        minusFive.times {
            zero -= 1
        }
        XCTAssert(zero == five)
    }
    
    func testAdditiveInverse() {
        XCTAssertTrue(zero.additiveInverse == 0)
        XCTAssertTrue(five.additiveInverse == minusFive)
        XCTAssertTrue(minusFive.additiveInverse == five)
        
        let unsignedFive: UInt = 5
        XCTAssertTrue(unsignedFive.additiveInverse == (-5).toIntMax())
    }
    
    func testMultiplicativeInverse() {
        XCTAssertNil(zero.multiplicativeInverse)
        XCTAssertTrue(five.multiplicativeInverse == 0.2)
        XCTAssertTrue(minusFive.multiplicativeInverse == -0.2)
    }
    
    func testRandom() {
        var random = Int(random: -5..<6)
        XCTAssertTrue(random >= -5 && random < 6)
        random = Int(random: nil)
        XCTAssertTrue(random >= Int(Int32.min) && random < Int(Int32.max))
    }
    
    func testTimeIntervals() {
        XCTAssert(five.seconds == 5.0)
        XCTAssert(five.minutes == 5.0 * 60)
        XCTAssert(five.hours == 5.0 * 60 * 60)
        XCTAssert(five.days == 5.0 * 60 * 60 * 24)
        XCTAssert(zero.seconds == 0.0)
        XCTAssert([zero.seconds, zero.minutes, zero.hours, zero.days].areAllElementsEqual)
    }
}
