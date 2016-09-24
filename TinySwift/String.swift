//
//  String.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension String {
    /**
     Creates a new string with randomized alphanumeric (`A-Z+a-z+0-9`, case-sensitive) characters.
     
     You can get `A-Z+0-9`, case insensitive randomized string by calling `uppercased()` on a result of this initializer.
     
     - parameter length: The desired length of a string.
     */
    public init(randomAlphanumericWithLength length: Int) {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var string = ""
        for _ in 0..<length {
            let index = letters.characters.index(letters.startIndex, offsetBy: Int(arc4random_uniform(UInt32(letters.characters.count))))
            string.append(letters[index])
        }
        
        self = string
    }
    
    /**
     Returns a new string made by removing from both ends of the String characters contained in Unicode General Category Z*, `U+000A ~ U+000D`, and `U+0085`.
     */
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
