//
//  TimeIntervalTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 08.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest

class TimeIntervalTests: XCTestCase {
    
    let ninetyMinutes: TimeInterval = 3600 * 1.5
    let twentySeconds: TimeInterval = 20
    let twentyFourHours: TimeInterval = 3600 * 24
    let almostFiveMinutes: TimeInterval = 299
    
    func testTime() {
        XCTAssert(ninetyMinutes.time(withFormat: .hhmmss) == "01:30:00")
        XCTAssert(ninetyMinutes.time(withFormat: .hmmss) == "1:30:00")
        XCTAssert(ninetyMinutes.time(withFormat: .hhmm) == "01:30")
        XCTAssert(ninetyMinutes.time(withFormat: .hmm) == "1:30")
        XCTAssert(ninetyMinutes.time(withFormat: .mmss) == "90:00")
        XCTAssert(ninetyMinutes.time(withFormat: .mss) == "90:00")
        
        XCTAssert(twentySeconds.time(withFormat: .hhmmss) == "00:00:20")
        XCTAssert(twentySeconds.time(withFormat: .hmmss) == "0:00:20")
        XCTAssert(twentySeconds.time(withFormat: .hhmm) == "00:00")
        XCTAssert(twentySeconds.time(withFormat: .hmm) == "0:00")
        XCTAssert(twentySeconds.time(withFormat: .mmss) == "00:20")
        XCTAssert(twentySeconds.time(withFormat: .mss) == "0:20")

        XCTAssert(twentyFourHours.time(withFormat: .hhmmss) == "24:00:00")
        XCTAssert(twentyFourHours.time(withFormat: .hmmss) == "24:00:00")
        XCTAssert(twentyFourHours.time(withFormat: .hhmm) == "24:00")
        XCTAssert(twentyFourHours.time(withFormat: .hmm) == "24:00")
        XCTAssert(twentyFourHours.time(withFormat: .mmss) == "1440:00")
        XCTAssert(twentyFourHours.time(withFormat: .mss) == "1440:00")

        XCTAssert(almostFiveMinutes.time(withFormat: .hhmmss) == "00:04:59")
        XCTAssert(almostFiveMinutes.time(withFormat: .hmmss) == "0:04:59")
        XCTAssert(almostFiveMinutes.time(withFormat: .hhmm) == "00:04")
        XCTAssert(almostFiveMinutes.time(withFormat: .hmm) == "0:04")
        XCTAssert(almostFiveMinutes.time(withFormat: .mmss) == "04:59")
        XCTAssert(almostFiveMinutes.time(withFormat: .mss) == "4:59")
    }
}
