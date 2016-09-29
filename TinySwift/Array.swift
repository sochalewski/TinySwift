//
//  Array.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension Collection where Index == Int {
    /// Returns a randomized array's element.
    public var random: Iterator.Element? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(endIndex - startIndex)))
        return self[index]
    }
}

public extension Array {
    /**
     Accesses the element at the specified position in a safe way.
     
     **Use the setter carefully**: When getter is 100% safe, setter does nothing if you try to set `nil` as a new value. You should use `Optional<T>(nilLiteral: ())` (where `T` is an array's element type) instead of `nil` or do not use it at all.
     
     The prohibited usage stops program execution in a debuggable state after printing message in playgrounds and `-Onone` builds.
     
     It cannot be fixed until Swift support for a generic subscripts. Read more [here](https://bugs.swift.org/browse/SR-115).
     
     - parameter index: The position of the element to access. `index` **must not** be greater than or equal to `startIndex` and less than `endIndex`, because elements are accessed in a safe way.
     */
    public subscript(safe index: Int) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            assert(newValue != nil, "Do not set nil as a new value through array's safe: subscript. You should use Optional<T>(nilLiteral: ()) (where T is an array's element type) instead of nil or do not use it at all. Read the documentation for more informations.")
            guard let newValue = newValue, indices.contains(index) else { return }
            self[index] = newValue
        }
    }
}

public extension Array where Element: Equatable {
    /// A Boolean value that determines whether all elements of the array are equal.
    public var areAllElementsEqual: Bool {
        guard let first = first else { return true }
        return !dropFirst().contains { $0 != first }
    }
}

public extension Collection where Iterator.Element: Integer {
    /// Returns the sum of all elements in the collection.
    var sum: Iterator.Element {
        return reduce(0, +)
    }
}

public extension Collection where Iterator.Element: Integer, Index == Int {
    /// Returns the average of all elements in the collection.
    var mean: Double {
        return isEmpty ? 0 : Double(sum.toIntMax()) / Double(endIndex - startIndex)
    }
    
    /// Returns the middle number in the collection, taken as the average of the two middle numbers when the collection has an even number of numbers.
    var median: Double {
        guard !isEmpty else { return 0 }
        let count = Int(endIndex - startIndex)
        let isCountEven = count % 2 == 0
        let sort = sorted()
        
        if isCountEven {
            return [sort[count / 2].toIntMax(), sort[(count / 2) + 1].toIntMax()].mean
        } else {
            return Double(sort[count / 2].toIntMax())
        }
    }
    
    /// Returns the expectation of the squared deviation of a random variable from its mean, and it informally measures how far a set of (random) numbers are spread out from their mean.
    var variance: Double {
        let arrayMean = mean
        let elements = map { pow((Double($0.toIntMax()) - arrayMean), 2) }
        
        return elements.mean
    }
    
    /// Returns a measure that is used to quantify the amount of variation or dispersion of a set of data values. A low standard deviation indicates that the data points tend to be close to the mean (also called the expected value) of the set, while a high standard deviation indicates that the data points are spread out over a wider range of values.
    var standardDeviation: Double {
        return sqrt(variance)
    }
}

public extension Collection where Iterator.Element == Int, Index == Int {
    var mode: [Int: Int]? {
        guard !isEmpty else { return nil }
        
        let sort = sorted()
        
        let set = NSOrderedSet(array: sort)
        var counts = [Int: Int]() // number: count
        
        counts[set.firstObject as! Int] = 0
        
        for (index, element) in set.enumerated() {
            if index == 0 { continue }
            counts[(counts.keys.sorted().last)!] = sort.index(of: element as! Int)! - counts.values.sum
            counts[element as! Int] = 0
        }
        
        counts[set.lastObject as! Int] = Int(endIndex - startIndex) - counts.values.sum
        
        return counts
    }
}

public extension Collection where Iterator.Element: FloatingPoint {
    /// Returns the sum of all elements in the collection.
    var sum: Iterator.Element {
        return reduce(0, +)
    }
}

public extension Collection where Iterator.Element: FloatingPoint, Index == Int {
    /// Returns the average of all elements in the collection.
    var mean: Iterator.Element {
        return isEmpty ? 0 : sum / Iterator.Element(endIndex - startIndex)
    }
    
    /// Returns the middle number in the collection, taken as the average of the two middle numbers when the collection has an even number of numbers.
    var median: Iterator.Element {
        guard !isEmpty else { return 0 }
        let count = Int(endIndex - startIndex)
        let isCountEven = count % 2 == 0
        let sort = sorted()
        
        if isCountEven {
            return [sort[count / 2], sort[(count / 2) + 1]].mean
        } else {
            return sort[count / 2]
        }
    }
    
    /// Returns the expectation of the squared deviation of a random variable from its mean, and it informally measures how far a set of (random) numbers are spread out from their mean.
    var variance: Iterator.Element {
        let arrayMean = mean
        
        let x = first! - arrayMean
        let elements = map { pow(($0 - arrayMean), 2) }
        
        return elements.mean
    }
    
    /// Returns a measure that is used to quantify the amount of variation or dispersion of a set of data values. A low standard deviation indicates that the data points tend to be close to the mean (also called the expected value) of the set, while a high standard deviation indicates that the data points are spread out over a wider range of values.
    var standardDeviation: Iterator.Element {
        return sqrt(variance)
    }
}
