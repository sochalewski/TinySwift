//
//  Array.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension Collection where Index == Int {
    /// Returns a randomized element of the collection.
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
    /// Returns the arithmetic mean of all elements in the collection.
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
            return [sort[(count / 2) - 1].toIntMax(), sort[count / 2].toIntMax()].mean
        } else {
            return Double(sort[count / 2].toIntMax())
        }
    }
    
    /**
     Returns the variance of an entire population (σ²).
     
     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    var variance: Double? {
        guard count >= 2 else { return nil }

        let arrayMean = mean
        let elements = map { pow((Double($0.toIntMax()) - arrayMean), 2) }
        
        return elements.mean
    }
    
    /**
     Returns the standard deviation (σ); a measure that is used to quantify the amount of variation or dispersion of a set of data values.
     
     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    var standardDeviation: Double? {
        guard let variance = variance else { return nil }

        return sqrt(variance)
    }

    /// Returns a dictionary with number of appearances for all elements of the collection.
    var appearances: [Iterator.Element: Int]? {
        guard !isEmpty else { return nil }
        
        let sort = sorted()
        let set = NSOrderedSet(array: sort).array as! [Iterator.Element]
        var counts = [set.first!: 0] // number: count
        
        set.dropFirst().forEach { element in
            let indexes = sort.enumerated().filter({ $0.element == element }).map { $0.offset }
            counts[(counts.keys.sorted().last)!] = indexes.first!.toIntMax() - IntMax(counts.values.sum)
            counts[element] = 0
        }
        
        counts[set.last!] = Int(endIndex - startIndex) - counts.values.sum
        
        return counts
    }
    
    /**
     Returns the value that appears most often in the collection.
     
     If there is a multimodal distribution, the value of the property is `nil`.
     */
    var mode: Iterator.Element? {
        guard let appearances = appearances, !isEmpty else { return nil }
        
        let sortedAppearances = Array(appearances.keys).sorted(by: { appearances[$0]! > appearances[$1]! })
        guard sortedAppearances.count != 1 else { return sortedAppearances.first }
        
        return appearances[sortedAppearances[0]]! > appearances[sortedAppearances[1]]! ? sortedAppearances[0] : nil
    }
}

public extension Collection where Iterator.Element: FloatingPoint {
    /// Returns the sum of all elements in the collection.
    var sum: Iterator.Element {
        return reduce(0, +)
    }
}

public extension Collection where Iterator.Element: FloatingPoint, Index == Int {
    /// Returns the arithmetic mean of all elements in the collection.
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
            return [sort[(count / 2) - 1], sort[count / 2]].mean
        } else {
            return sort[count / 2]
        }
    }
    
    /**
     Returns the variance of an entire population (σ²).
     
     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    var variance: Iterator.Element? {
        guard count >= 2 else { return nil }
        
        let arrayMean = mean
        let elements = map { ($0 - arrayMean) * ($0 - arrayMean) }
        
        return elements.mean
    }
    
    /**
     Returns the standard deviation (σ); a measure that is used to quantify the amount of variation or dispersion of a set of data values.
     
     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    var standardDeviation: Iterator.Element? {
        guard let variance = variance else { return nil }
        
        return sqrt(variance)
    }
}

public extension Collection where Iterator.Element: FloatingPoint, Iterator.Element: Hashable, Index == Int {
    /// Returns a dictionary with number of appearances for all elements of the collection.
    var appearances: [Iterator.Element: Int]? {
        guard !isEmpty else { return nil }
        
        let sort = sorted()
        let set = NSOrderedSet(array: sort).array as! [Iterator.Element]
        var counts = [set.first!: 0] // number: count
        
        set.dropFirst().forEach { element in
            let indexes = sort.enumerated().filter({ $0.element == element }).map { $0.offset }
            counts[(counts.keys.sorted().last)!] = indexes.first!.toIntMax() - IntMax(counts.values.sum)
            counts[element] = 0
        }
        
        counts[set.last!] = Int(endIndex - startIndex) - counts.values.sum
        
        return counts
    }
    
    /**
     Returns the value that appears most often in the collection.
     
     If there is a multimodal distribution, the value of the property is `nil`.
     */
    var mode: Iterator.Element? {
        guard let appearances = appearances, !isEmpty else { return nil }
        
        let sortedAppearances = Array(appearances.keys).sorted(by: { appearances[$0]! > appearances[$1]! })
        guard sortedAppearances.count != 1 else { return sortedAppearances.first }
        
        return appearances[sortedAppearances[0]]! > appearances[sortedAppearances[1]]! ? sortedAppearances[0] : nil
    }
}
