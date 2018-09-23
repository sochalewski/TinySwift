//
//  UIDeviceTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 31.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class UIDeviceTests: XCTestCase {
    
    private let allPhones = PhoneModel.allCases
    private let allPads = PadModel.allCases
    private let allPods = PodModel.allCases
    private let allTVs = TVModel.allCases
    private lazy var allDevices: [DeviceType] = {
        let phones = allPhones.map { DeviceType.phone($0) }
        let pads = allPads.map { DeviceType.pad($0) }
        let pods = allPods.map { DeviceType.pod($0) }
        let tvs = allTVs.map { DeviceType.tv($0) }
        
        return [.unknown, .simulator] + phones + pads + pods + tvs
    }()
    
    func testDeviceType() {
        XCTAssertTrue(UIDevice.current.device == DeviceType.simulator)
    }
    
    func testDeviceEquatable() {
        allDevices.forEach {
            XCTAssert($0 == $0)
            XCTAssert($0 != allDevices[safe: allDevices.index(of: $0)!.advanced(by: 1)] ?? .unknown)
        }
    }
    
    func testPhoneEquatable() {
        allPhones.forEach {
            XCTAssert($0 == $0)
            XCTAssert($0 != PhoneModel(rawValue: $0.rawValue + 1) ?? .unknown)
        }
    }
    
    func testPhoneComparable() {
        allPhones.forEach {
            guard let newerPhone = PhoneModel(rawValue: $0.rawValue + 1) else { return }
            XCTAssert($0 < newerPhone)
        }
    }
    
    func testPadEquatable() {
        allPads.forEach {
            XCTAssert($0 == $0)
            XCTAssert($0 != allPads[safe: allPads.index(of: $0)!.advanced(by: 1)] ?? .unknown)
        }
    }
    
    func testPodEquatable() {
        allPods.forEach {
            XCTAssert($0 == $0)
            XCTAssert($0 != PodModel(rawValue: $0.rawValue + 1) ?? .unknown)
        }
    }
    
    func testPodComparable() {
        allPods.forEach {
            guard let newerPod = PodModel(rawValue: $0.rawValue + 1) else { return }
            XCTAssert($0 < newerPod)
        }
    }
    
    func testTVEquatable() {
        allTVs.forEach {
            XCTAssert($0 == $0)
            XCTAssert($0 != TVModel(rawValue: $0.rawValue + 1) ?? .unknown)
        }
    }
    
    func testTVComparable() {
        allTVs.forEach {
            guard let newerTV = TVModel(rawValue: $0.rawValue + 1) else { return }
            XCTAssert($0 < newerTV)
        }
    }
    
    func testDiskSpace() {
        XCTAssert(UIDevice.current.freeDiskSpace > 0)
        XCTAssert(UIDevice.current.diskSize > 0)
        XCTAssert(UIDevice.current.diskSize > UIDevice.current.freeDiskSpace)
    }
}
