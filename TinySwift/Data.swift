//
//  Data.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 09.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension Data {
    /// Returns a hexadecimal encoded String.
    public var hexadecimalString: String {
        return map { String(format: "%02x", $0) }.joined(separator: "")
    }
    
    /**
     Initialize a `Data` from the hexadecimal string representation.
     
     Sample usage:
     
         let hexString = "48656c6c6f"
         let data = Data(hexadecimalString: hexString)
         // data is now <48656c6c6f>
     
     - parameter string: The hexadecimal string representation.
     - note: If the string has any non-hexadecimal characters, those are ignored and only hexadecimal characters are processed.
     - returns: The data represented by the hexadecimal string or `nil` if a data cannot be created.
    */
    public init?(hexadecimalString string: String) {
        var data = Data(capacity: string.count / 2)
        
        let regex = try? NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex?.enumerateMatches(in: string, options: [], range: NSMakeRange(0, string.count)) { match, flags, stop in
            let byteString = (string as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        
        guard data.count > 0 else { return nil }
        
        self = data
    }
}
