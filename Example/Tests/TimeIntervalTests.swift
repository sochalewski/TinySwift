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
        XCTAssert(ninetyMinutes.time(with: .hhmmss) == "01:30:00")
        XCTAssert(ninetyMinutes.time(with: .hmmss) == "1:30:00")
        XCTAssert(ninetyMinutes.time(with: .hhmm) == "01:30")
        XCTAssert(ninetyMinutes.time(with: .hmm) == "1:30")
        XCTAssert(ninetyMinutes.time(with: .mmss) == "90:00")
        XCTAssert(ninetyMinutes.time(with: .mss) == "90:00")
        
        XCTAssert(twentySeconds.time(with: .hhmmss) == "00:00:20")
        XCTAssert(twentySeconds.time(with: .hmmss) == "0:00:20")
        XCTAssert(twentySeconds.time(with: .hhmm) == "00:00")
        XCTAssert(twentySeconds.time(with: .hmm) == "0:00")
        XCTAssert(twentySeconds.time(with: .mmss) == "00:20")
        XCTAssert(twentySeconds.time(with: .mss) == "0:20")

        XCTAssert(twentyFourHours.time(with: .hhmmss) == "24:00:00")
        XCTAssert(twentyFourHours.time(with: .hmmss) == "24:00:00")
        XCTAssert(twentyFourHours.time(with: .hhmm) == "24:00")
        XCTAssert(twentyFourHours.time(with: .hmm) == "24:00")
        XCTAssert(twentyFourHours.time(with: .mmss) == "1440:00")
        XCTAssert(twentyFourHours.time(with: .mss) == "1440:00")

        XCTAssert(almostFiveMinutes.time(with: .hhmmss) == "00:04:59")
        XCTAssert(almostFiveMinutes.time(with: .hmmss) == "0:04:59")
        XCTAssert(almostFiveMinutes.time(with: .hhmm) == "00:04")
        XCTAssert(almostFiveMinutes.time(with: .hmm) == "0:04")
        XCTAssert(almostFiveMinutes.time(with: .mmss) == "04:59")
        XCTAssert(almostFiveMinutes.time(with: .mss) == "4:59")
    }
}
