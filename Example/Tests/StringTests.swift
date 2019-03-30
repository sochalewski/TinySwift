//
//  StringTests.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import XCTest
import TinySwift

class StringTests: XCTestCase {
    
    func testRandom() {
        let desiredLength = 12
        
        let randomString1 = String(random: .alphanumeric(caseSensitive: true), length: desiredLength)
        XCTAssertTrue(randomString1.count == desiredLength, "Randomized string has wrong length")
        XCTAssertFalse(randomString1.trimmed.isEmpty, "Randomized string contains only whitespaces")
        
        let randomString2 = String(random: .alphanumeric(caseSensitive: false), length: desiredLength)
        XCTAssertTrue(randomString2.uppercased() == randomString2, "Case insensitive string should be equal with uppercased string")
        XCTAssertTrue(randomString2.count == desiredLength, "Randomized string has wrong length")
        XCTAssertFalse(randomString2.trimmed.isEmpty, "Randomized string contains only whitespaces")
        
        let randomString3 = String(random: .alphabetic(caseSensitive: true), length: desiredLength)
        XCTAssertTrue(randomString3.count == desiredLength, "Randomized string has wrong length")
        XCTAssertFalse(randomString3.trimmed.isEmpty, "Randomized string contains only whitespaces")
        
        let randomString4 = String(random: .alphabetic(caseSensitive: false), length: desiredLength)
        XCTAssertTrue(randomString4.uppercased() == randomString4, "Case insensitive string should be equal with uppercased string")
        XCTAssertTrue(randomString4.count == desiredLength, "Randomized string has wrong length")
        XCTAssertFalse(randomString4.trimmed.isEmpty, "Randomized string contains only whitespaces")
        
        let randomString5 = String(random: .numeric, length: desiredLength)
        XCTAssertTrue(randomString5.count == desiredLength, "Randomized string has wrong length")
        XCTAssertFalse(randomString5.trimmed.isEmpty, "Randomized string contains only whitespaces")
        
        let randomString6 = String(random: .numeric, length: desiredLength, nonRepeating: true)
        XCTAssertTrue(randomString6.count == 10, "Randomized string has wrong length")
        XCTAssertTrue(Array(Array(randomString6).appearances!.values) == Array(repeatElement(1, count: 10)), "Each character should appear exactly once")
        XCTAssertFalse(randomString6.trimmed.isEmpty, "Randomized string contains only whitespaces")
    }
    
    func testPath() {
        let path: FileManager.SearchPathDirectory = .documentDirectory
        let userDirectory = String(path: path)
        XCTAssertEqual(userDirectory, FileManager.default.urls(for: path, in: .userDomainMask).first?.relativePath, "Path for the document directory should equal with the one got from FileManager")
    }
    
    func testTrimmed() {
        let stringToBeTrimmed = "\n\n  XX \n \r \t "
        XCTAssert(stringToBeTrimmed.trimmed.count == 2, "Trimmed string length is not desired length")
    }
    
    func testInitials() {
        let name = "Piotr Sochalewski"
        let lorem = "Lorem ipsum dolor  \n    sit amet  "
        XCTAssert(name.initials == "PS", "Initials should return first letters")
        XCTAssert(lorem.initials == "Lidsa", "Initials should return first letters even if there are multiple spaces or new lines")
    }
    
    func testLines() {
        let lorem = ["Lorem ipsum", "dolor sit amet", "consectetur adipiscing elit"]
        let string = lorem.joined(separator: "\n")
        let lines = string.lines
        XCTAssert(lines == lorem, "Lines should equal the array that elements joined created the string")
    }
    
    func testNonEmptyLines() {
        let string = "Lorem ipsum\n  \t \ndolor sit amet\n \n  \n consectetur adipiscing elit\n  \n"
        XCTAssert(string.nonEmptyLines.count == 3, "Non empty lines should have three elements")
    }
    
    func testOccurrences() {
        let swift = "Swifty Swift is the swiftest"
        XCTAssert(swift.occurrences(of: "Swift") == 2)
        XCTAssert(swift.occurrences(of: "swift") == 1)
        XCTAssert(swift.uppercased().occurrences(of: "SWIFT") == 3)
        XCTAssert(swift.occurrences(of: " ") == 4)
        XCTAssert(swift.occurrences(of: "Obj-C") == 0)
    }
    
    func testHexString() {
        let hex = "54696e795377696674"
        guard let data = hex.dataFromHexadecimalString else { XCTFail(); return }
        
        XCTAssert(data.count == hex.count / 2)
        XCTAssert(String(data: data, encoding: .utf8) == "TinySwift")
    }
    
    func testCamelCase() {
        let swift = "Swifty Swift is the swiftest"
        XCTAssert(swift.camelCased != swift.upperCamelCased)
        XCTAssert(swift.camelCased == "swiftySwiftIsTheSwiftest")
        XCTAssert(swift.upperCamelCased == "SwiftySwiftIsTheSwiftest")
        
        let crazySwift = "SwiFTy SwIfT IS the SwifTest"
        XCTAssert(swift.camelCased == crazySwift.camelCased)
        XCTAssert(swift.upperCamelCased == crazySwift.upperCamelCased)
        
        let emptyString = String()
        XCTAssert([emptyString, emptyString.upperCamelCased, emptyString.camelCased].areAllElementsEqual)
    }
    
    func testIsEmailAddress() {
        let validAddresses = ["sochalewski@gmail.com",
                              "very.unusual.”@”.unusual.com@example.com",
                              """
                              very.”(),:;<>[]”.VERY.”very@\\ "very”.unusual@strange.example.com
                              """]
        let invalidAddresses = ["あいうえお@domain.com",
                                "email@111.222.333.44444",
                                "email.@domain.com",
                                "email@-domain.com",
                                "email@domain..com"]
        
        validAddresses.forEach { XCTAssertTrue($0.isEmailAddress) }
        invalidAddresses.forEach { XCTAssertFalse($0.isEmailAddress) }
    }
    
    func testLocalized() {
        XCTAssert("WORD".localized == "TinySwift")
        XCTAssert(NSLocalizedString("WORD", comment: "") == "WORD".localized)
    }
    
    func testEmptyIfNil() {
        let string1: String? = "non-nil"
        let string2: String? = nil
        
        XCTAssert(string1.emptyIfNil == "non-nil")
        XCTAssert(string2.emptyIfNil == "")
    }
    
    func testNilIfEmpty() {
        let string1 = "non-empty"
        let string2 = ""
        
        XCTAssert(string1.nilIfEmpty == "non-empty")
        XCTAssertNil(string2.nilIfEmpty)
    }
}
