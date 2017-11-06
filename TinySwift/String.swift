//
//  String.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension String {
    /// The collection of Latin letters and Arabic digits or a text constructed from this collection.
    public enum RandomString {
        /// The character set with 36 (`A-Z+0-9`, case insensitive) or 62 (`A-Z+a-z+0-9`, case-sensitive) alphanumeric characters.
        case alphanumeric(caseSensitive: Bool)
        /// The character set with 26 (`A-Z`, case insensitive) or 52 (`A-Z+a-z`, case-sensitive) Latin letters.
        case alphabetic(caseSensitive: Bool)
        /// The character set with 10 (`0-9`) Arabic digits.
        case numeric
        
        fileprivate var characterSet: String {
            switch self {
            case .alphanumeric(true): return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            case .alphanumeric(false): return "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            case .alphabetic(true): return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            case .alphabetic(false): return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            case .numeric: return "0123456789"
            }
        }
    }
    
    /**
     Creates a new string with randomized characters.
     
     - parameter random: The desired randomized character set.
     - parameter length: The desired length of a string.
     - parameter nonRepeating: The boolean value that determines whether characters in the initialized can or cannot be repeated. The default value is `false`. If `true` and length is greater than number of characters in selected character set, then string with maximum allowed length will be produced.
     - returns: The new string with randomized characters.
     */
    public init(random: RandomString, length: Int, nonRepeating: Bool = false) {
        var letters = random.characterSet
        
        var length = length
        if length > random.characterSet.count, nonRepeating {
            length = random.characterSet.count
        }
        
        var string = ""
        
        while string.count < length {
            let index = letters.index(letters.startIndex, offsetBy: Int(arc4random_uniform(UInt32(letters.count))))
            let letter = letters[index]
            string.append(letter)
            if nonRepeating {
                letters.remove(at: index)
            }
        }
        
        self = string
    }
    
    /**
     Creates a new string with a path for the specified directories in the user's home directory.
     
     - parameter directory: The location of a variety of directories
     - note: The directory returned by this method may not exist. This method simply gives you the appropriate location for the requested directory. Depending on the application’s needs, it may be up to the developer to create the appropriate directory and any in between.
     - returns: The string with a path for the specified directories in the user's home directory or `nil` if a path cannot be found.
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
            .map { $0[..<index(after: startIndex)] }
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
    
    /// Returns a data created from the value treated as a hexadecimal string.
    public var dataFromHexadecimalString: Data? {
        guard let regex = try? NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive) else { return nil }
        
        var data = Data(capacity: count / 2)
        regex.enumerateMatches(in: self, options: [], range: NSRange(location: 0, length: count)) { match, _, _ in
            guard let match = match else { return }
            let byteString = (self as NSString).substring(with: match.range)
            guard var num = UInt8(byteString, radix: 16) else { return }
            data.append(&num, count: 1)
        }
        
        return data
    }
    
    /**
     Returns a camel case version of the string.
     
     Here’s an example of transforming a string to all camel case letters.
     
     let variable = "Find way home"
     print(variable.camelCased)
     // Prints "findWayHome"
     */
    public var camelCased: String {
        guard let _ = rangeOfCharacter(from: .whitespacesAndNewlines) else { return lowercased() }
        
        let first = lowercased()[..<index(after: startIndex)]
        let rest = String(upperCamelCased.dropFirst())
        
        return "\(first)\(rest)"
    }
    
    /**
     Returns an upper camel case version of the string.
     
     Here’s an example of transforming a string to all upper camel case letters.
     
     let variable = "find way home"
     print(variable.camelCased)
     // Prints "FindWayHome"
     */
    public var upperCamelCased: String {
        return capitalized.components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    /// Returns whether the value is a valid email address.
    public var isEmailAddress: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: .reportCompletion, range: NSRange(location: 0, length: count))
        
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    ///  Returns a localized version of a string, using the main bundle.
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Returns the number of occurrences of a given case-sensitive string within the `String`.
    public func occurrences(of substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }
}
