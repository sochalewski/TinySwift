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
     Creates a new string with a path for the specified directories in the user's home directory.
     
     - parameter directory: The location of a variety of directories
     - note: The directory returned by this method may not exist. This method simply gives you the appropriate location for the requested directory. Depending on the application’s needs, it may be up to the developer to create the appropriate directory and any in between.
     */
    public init?(path directory: FileManager.SearchPathDirectory) {
        guard let path = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first else { return nil }
        self = path
    }
    
    /**
     Returns a new string made by removing from both ends of the String characters contained in Unicode General Category Z*, `U+000A ~ U+000D`, and `U+0085`.
     */
    public var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Returns a new string made by first letter of the each String word.
    public var initials: String? {
        return components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .map { $0.substring(to: index(after: startIndex)) }
            .joined()
    }
    
    /// Returns an array of strings where elements are the String lines.
    public var lines: [String] {
        var result = [String]()
        enumerateLines { (line, _) in
            result.append(line)
        }
        
        return result
    }
    
    /// Returns an array of strings where elements are the String non-empty lines.
    public var nonEmptyLines: [String] {
        return lines.filter { !$0.trimmed.isEmpty }
    }
    
    /// Returns the number of occurrences of a given case-sensitive string within the `String`.
    public func occurrences(of substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }
}
