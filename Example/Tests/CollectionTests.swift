//
//  CollectionTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class CollectionTests: XCTestCase {
    
    var ints: [Int]!
    var doubles: [Double]!
    
    override func setUp() {
        super.setUp()
        
        ints = Array(stride(from: 1, through: 6, by: 1))
        doubles = [1.2, 2.7, 3.2, 4.0, 5.1, 6.9]
    }

    func testRandomElement() {
        XCTAssert(ints.contains(ints.random!), "Array does not contain randomized element")
        XCTAssert(ints.set.contains(ints.set.random!), "Set does not contain randomized element")
    }
    
    func testAreAllElementsEqual() {
        let equalArray = Array(repeating: 0, count: 5)
        let nonEqualArray = equalArray + [1]
        XCTAssert(equalArray.areAllElementsEqual, "False negative result on Array.areAllElementsEqual()")
        XCTAssert(!nonEqualArray.areAllElementsEqual, "False positive result on Array.areAllElementsEqual()")
    }
    
    func testShuffle() {
        let shuffledInts = ints.shuffled
        XCTAssert(shuffledInts.count == ints.count)
        XCTAssert(shuffledInts != ints)
    }
    
    func testSafeSubscript() {
        var fiveElements = Array(repeating: 0, count: 5)
        XCTAssertNil(fiveElements[safe: -1], "Element with negative index should be optional/nil and not cause a crash")
        XCTAssertNil(fiveElements[safe: fiveElements.count], "Element out of bounds got with safe: subscript should be optional/nil and not cause a crash")
        XCTAssertNotNil(fiveElements[safe: fiveElements.count - 1], "Element from bounds got with safe: subscript should exist")
        fiveElements[safe: 2] = 5
        XCTAssert(fiveElements[safe: 2] == 5, "Elements should be able to change through the safe: subscript accessor")
        
        var fiveOptionalElements: [Int?] = Array(fiveElements)
        XCTAssert(fiveOptionalElements.count == fiveOptionalElements.flatMap({ $0 }).count, "Pre-condition: fiveOptionalElements array should not have nils inside")
        fiveOptionalElements[safe: 2] = nil
        XCTAssert(fiveOptionalElements[2] == nil, "Changed element should be nil")
        XCTAssert(fiveOptionalElements.count - 1 == fiveOptionalElements.flatMap({ $0 }).count, "Changed array should have less not-nil elements")
        XCTAssert(fiveOptionalElements.count == fiveOptionalElements.count, "Changed array should have the same number of elements")
    }
    
    func testSet() {
        let uniqueStrings = ["foo", "bar", "nil"]
        let uniqueStringsSet = uniqueStrings.set
        XCTAssert(uniqueStringsSet.count == uniqueStrings.count)
        let strings = ["foo", "bar", "foo"]
        let stringsSet = strings.set
        XCTAssert(stringsSet.count == 2)
    }
    
    func testSum() {
        XCTAssert(doubles.sum == doubles.reduce(0, +))
        XCTAssert(ints.sum == ints.reduce(0, +))
    }
    
    func testArithmeticMean() {
        XCTAssert(doubles.arithmeticMean == doubles.reduce(0, +) / Double(doubles.count))
        XCTAssert(ints.arithmeticMean == Double(ints.reduce(0, +)) / Double(ints.count))
    }
    
    func testGeometricMean() {
        XCTAssert(doubles.geometricMean == pow(doubles.reduce(1, *), 1 / Double(doubles.count)))
        XCTAssert(ints.geometricMean == pow(Double(ints.reduce(1, *)), 1 / Double(ints.count)))
    }
    
    func testMedian() {
        XCTAssert(doubles.median == [doubles[doubles.count / 2], doubles[doubles.count / 2 - 1]].arithmeticMean, "Sample even float array median is wrong.")
        XCTAssert(ints.median == [ints[doubles.count / 2], ints[doubles.count / 2 - 1]].arithmeticMean, "Sample even int array median is wrong.")
        
        let odddoubles = doubles.dropLast()
        XCTAssert(odddoubles.median == odddoubles[odddoubles.count / 2], "Sample odd float array median is wrong.")
        let oddInts = ints.dropLast()
        XCTAssert(oddInts.median == Double(oddInts[oddInts.count / 2]), "Sample odd int array median is wrong.")
    }
    
    func testVariance() {
        XCTAssert(doubles.variance == 3.2758333333333333)
        XCTAssert(ints.variance == 2.9166666666666667)
    }
    
    func testStandardDeviation() {
        XCTAssert(doubles.standardDeviation == sqrt(3.2758333333333333))
        XCTAssert(ints.standardDeviation == sqrt(2.9166666666666667))
    }
    
    func testAppearancesAndMode() {
        // an array where 0 appears 3x, 2 - 21x, 5 - 14x, 7 - 3x and 140 - 2x.
        let array: [Int] = Array(
            [Array(repeating: 5, count: 14),
             Array(repeating: 0, count: 1),
             Array(repeating: 2, count: 21),
             Array(repeating: 140, count: 2),
             Array(repeating: 0, count: 2),
             Array(repeating: 7, count: 3)]
                .joined(separator: []))
        
        guard let appearances = array.appearances else { XCTFail("Cannot return appeareances"); return }
        
        XCTAssert(appearances[0] == 3)
        XCTAssert(appearances[2] == 21)
        XCTAssert(appearances[5] == 14)
        XCTAssert(appearances[7] == 3)
        XCTAssert(appearances[140] == 2)
        XCTAssert(appearances.keys.count == 5)
        
        XCTAssert(array.mode == 2)
    }
    
    func testAppearanceAndModeForSingleIntArray() {
        let array = [5]
        
        guard let appearances = array.appearances else { XCTFail("Cannot return appeareances"); return }

        XCTAssert(appearances[5] == 1)
        XCTAssert(appearances.keys.count == 1)

        XCTAssert(array.mode == 5)
    }
    
    func testAppearanceAndModeForSingleFloatArray() {
        let array = [5.1]
        
        guard let appearances = array.appearances else { XCTFail("Cannot return appeareances"); return }
        
        XCTAssert(appearances[5.1] == 1)
        XCTAssert(appearances.keys.count == 1)
        
        XCTAssert(array.mode == 5.1)
    }
    
    func testRemove() {
        let count = ints.count
        XCTAssertTrue(ints.remove(element: 1))
        XCTAssertFalse(ints.remove(element: 999))
        XCTAssert(count == ints.count + 1)
        
    }
}
