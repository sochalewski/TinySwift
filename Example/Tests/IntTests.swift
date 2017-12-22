//
//  IntTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 27.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class IntTests: XCTestCase {
    
    private let zero = 0
    private let five = 5
    private let minusFive = -5
    
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
        let realPrimes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997]
        let numbers = Array(-1...1000)
        
        numbers.forEach { number in
            let isPrime = realPrimes.contains(number)
            XCTAssert(number.isPrime == isPrime, "\(number) wrongly recognized")
        }
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
        XCTAssertTrue(unsignedFive.additiveInverse == Int64(-5))
    }
    
    func testMultiplicativeInverse() {
        XCTAssertNil(zero.multiplicativeInverse)
        XCTAssertTrue(five.multiplicativeInverse == 0.2)
        XCTAssertTrue(minusFive.multiplicativeInverse == -0.2)
    }
    
    func testRandom() {
        (0...100).forEach { _ in
            let random = Int.random
            XCTAssert(random >= -INT32_MAX && random <= INT32_MAX)
            XCTAssertNotEqual(random, Int.random)
        }
    }
    
    func testRandomUpperBound() {
        (0...100).forEach { _ in
            let random = Int(random: Int(INT32_MAX))
            XCTAssert(random >= 0 && random <= INT32_MAX)
            XCTAssertNotEqual(random, Int.random)
        }
        
        let smallRandoms = (0...100).map { _ in Int(random: 2) }
        XCTAssertFalse(smallRandoms.filter({ $0 == 0 }).isEmpty)
        XCTAssertFalse(smallRandoms.filter({ $0 == 1 }).isEmpty)
        XCTAssertTrue(smallRandoms.filter({ !($0 == 0 || $0 == 1) }).isEmpty)
    }
    
    func testRandomRange() {
        /// Positive values
        let positiveRandom = Int(random: 1...1_000_000)
        XCTAssert(positiveRandom >= 1 && positiveRandom <= 1_000_000)
        XCTAssertNotEqual(positiveRandom, Int(random: 1_000_001...2_000_000))
        
        /// Negative values
        let negativeRandom = Int(random: (-5)...(-3))
        XCTAssert(negativeRandom >= -5 && negativeRandom <= -3)
        
        /// Small values
        let smallRandoms = (0...100).map { _ in Int(random: 0...1) }
        XCTAssertFalse(smallRandoms.filter({ $0 == 0 }).isEmpty)
        XCTAssertFalse(smallRandoms.filter({ $0 == 1 }).isEmpty)
        XCTAssertTrue(smallRandoms.filter({ !($0 == 0 || $0 == 1) }).isEmpty)
    }
    
    func testTimeIntervals() {
        XCTAssert(five.seconds == 5.0)
        XCTAssert(five.minutes == 5.0 * 60)
        XCTAssert(five.hours == 5.0 * 60 * 60)
        XCTAssert(five.days == 5.0 * 60 * 60 * 24)
        XCTAssert(zero.seconds == 0.0)
        XCTAssert([zero.seconds, zero.minutes, zero.hours, zero.days].areAllElementsEqual)
    }
    
    func testAngles() {
        let fiveDegToRad = five.degreesToRadians
        XCTAssertEqual(fiveDegToRad, 0.087, accuracy: 0.001)
        XCTAssert(fiveDegToRad.radiansToDegrees == Double(five))
        XCTAssertEqual(five.radiansToDegrees, 286.478, accuracy: 0.01)
    }
}
