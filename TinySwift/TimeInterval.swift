//
//  TimeInterval.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 08.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public enum TimeFormat {
    /// The time format represented using at least two digits of hour (from 00 to ∞), two digits of minute (from 00 to 59) and two digits of second (from 00 to 59) separated by colons.
    case hhmmss
    /// The time format represented using at least one digit of hour (from 0 to ∞), two digits of minute (from 00 to 59) and two digits of second (from 00 to 59) separated by colons.
    case hmmss
    /// The time format represented using at least two digits of hour (from 00 to ∞) and two digits of minute (from 00 to 59) separated by colons.
    case hhmm
    /// The time format represented using at least one digit of hour (from 0 to ∞) and two digits of minute (from 00 to 59) separated by colons.
    case hmm
    /// The time format represented using at least two digits of minute (from 00 to ∞) and two digits of second (from 00 to 59) separated by colons.
    case mmss
    /// The time format represented using at least one digit of minute (from 0 to ∞) and two digits of second (from 00 to 59) separated by colons.
    case mss
    
    fileprivate var format: String {
        switch self {
        case .hhmmss:
            return "%02lu:%02lu:%02lu"
        case .hmmss:
            return "%01lu:%02lu:%02lu"
        case .hhmm, .mmss:
            return "%02lu:%02lu"
        case .hmm, .mss:
            return "%01lu:%02lu"
        }
    }
    
    fileprivate func arguments(for seconds: Int) -> [Int] {
        switch self {
        case .hhmmss, .hmmss:
            return [seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60]
        case .hhmm, .hmm:
            return [seconds / 3600, (seconds % 3600) / 60]
        case .mmss, .mss:
            return [seconds / 60, seconds % 60]
        }
    }
}

public extension TimeInterval {
    /**
     Returns a string representation of a given time interval.
     
     - parameter timeFormat: The desired date format.
     - returns: A string representation of time interval.
     */
    public func time(withFormat timeFormat: TimeFormat) -> String {
        return String(format: timeFormat.format, arguments: timeFormat.arguments(for: Int(rounded())))
    }
}
