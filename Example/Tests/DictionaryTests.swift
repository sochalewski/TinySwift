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
    
    func testRandom() {
        guard let random = dictionary.random else { XCTFail(); return }
        XCTAssert(random.count == 1)
        XCTAssert(dictionary.keys.contains(random.keys.first!))
        XCTAssert(dictionary.values.contains(random.values.first!))
    }
}
