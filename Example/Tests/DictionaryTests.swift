//
//  DictionaryTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 16.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class DictionaryTests: XCTestCase {
    
    let dictionary = ["Dracula" : "Bram Stoker", "The Shining" : "Stephen King", "Heart-Shaped Box" : "Joe Hill"]
    
    func testShuffle() {
        let shuffled = dictionary.shuffled
        XCTAssert(Array(shuffled.keys).count == Array(dictionary.keys).count)
        XCTAssert(Array(shuffled.values).count == Array(dictionary.values).count)
    }
    
    func testRandom() {
        guard let random = dictionary.random else { XCTFail(); return }
        XCTAssert(random.count == 1)
        XCTAssert(dictionary.keys.contains(random.keys.first!))
        XCTAssert(dictionary.values.contains(random.values.first!))
    }
}
