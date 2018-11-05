//
//  Collection.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 24.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation
#if !os(watchOS)
    import GameplayKit
#endif

fileprivate extension Array where Element: ExpressibleByNilLiteral {
    fileprivate subscript(safeOptional index: Index) -> Element {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            guard indices.contains(index) else { return }
            self[index] = newValue
        }
    }
}

public extension Array {
    fileprivate var isOptionalAllowed: Bool {
        return String(describing: Element.self).hasPrefix("Optional<") // ugh
    }
    
    /**
     Accesses the element at the specified position in a safe way.
     
     - parameter index: The position of the element to access. `index` **may or may not** be greater than or equal to `startIndex` and less than `endIndex`, because elements are accessed in a safe way.
     */
    public subscript(safe index: Index) -> Element? {
        get {
            if isOptionalAllowed {
                var selfOfOptionals = self as Array<Optional<Any>>
                return selfOfOptionals[safeOptional: index] as? Element
            }
            
            return indices.contains(index) ? self[index] : nil
        }
        set {
            guard indices.contains(index) else { return }

            if let newValue = newValue {
                self[index] = newValue
                return
            }
            
            guard isOptionalAllowed else { fatalError("nil cannot be assigned to type '\(String(describing: Element.self))'") }
            var selfOfOptionals = self as Array<Optional<Any>>
            selfOfOptionals[safeOptional: index] = newValue
            self = selfOfOptionals as! [Element]
        }
    }
    
    #if !os(watchOS)
    /// Shuffles the objects in the collection. The objects in the collection are shuffled based on a Fisher-Yates shuffle.
    @available(iOS 9.0, tvOS 9.0, *)
    public mutating func shuffle() {
        self = GKARC4RandomSource.sharedRandom().arrayByShufflingObjects(in: self) as! [Element]
    }
    
    /// Returns a shuffled instance of the collection. The objects in the collection are shuffled based on a Fisher-Yates shuffle.
    @available(iOS 9.0, tvOS 9.0, *)
    public var shuffled: [Element] {
        var copy = self
        copy.shuffle()
        
        return copy
    }
    #endif
}

public extension Array where Iterator.Element: Equatable {
    /**
     Remove the element.
     
     - parameter element: The element to be removed.
     - returns: A bool value that represents if the element was successfully removed.
     */
    @discardableResult
    public mutating func remove(element: Iterator.Element) -> Bool {
        guard let index = index(of: element) else { return false }
        remove(at: index)
        
        return true
    }
}

public extension RandomAccessCollection where Iterator.Element: Hashable {
    /// Returns a set containing the elements of the collection.
    public var set: Set<Iterator.Element> {
        return Set(self)
    }
}

public extension Set {
    /// Returns a randomized element from the collection.
    @available(swift, deprecated: 4.2, message: "Deprecated in favor of Collection.randomElement().")
    public var random: Iterator.Element? {
        return Array(self).random
    }
}

public extension RandomAccessCollection {
    /// Returns a randomized element from the collection.
    @available(swift, deprecated: 4.2, message: "Deprecated in favor of Collection.randomElement().")
    public var random: Iterator.Element? {
        guard !isEmpty else { return nil }
        let offset = arc4random_uniform(numericCast(count))
        let index = self.index(startIndex, offsetBy: numericCast(offset))
        
        return self[index]
    }
}

public extension RandomAccessCollection where Iterator.Element: Hashable {
    /// A Boolean value that determines whether all elements of the collection are equal.
    public var areAllElementsEqual: Bool {
        guard !isEmpty else { return true }

        #if swift(>=4.2)
            return allSatisfy { $0 == first! }
        #else
            return !dropFirst().contains { $0 != first! }
        #endif
    }
    
    /// Returns a dictionary with number of appearances for all elements of the collection.
    public var appearances: [Iterator.Element : Int]? {
        guard !isEmpty else { return nil }
        
        var counts = [first! : 0] // number: count
        forEach { counts[$0] = (counts[$0] ?? 0) + 1 }
        
        return counts
    }
    
    /**
     Returns the value that appears most often in the collection.
     
     If there is a multimodal distribution, the value of the property is `nil`.
     */
    public var mode: Iterator.Element? {
        guard let appearances = appearances, !isEmpty else { return nil }
        
        let sortedAppearances = Array(appearances.keys).sorted { appearances[$0]! > appearances[$1]! }
        guard sortedAppearances.count != 1 else { return sortedAppearances.first }
        
        return appearances[sortedAppearances[0]]! > appearances[sortedAppearances[1]]! ? sortedAppearances[0] : nil
    }
}

public extension Sequence where Iterator.Element: Numeric {
    /// Returns the sum of all elements in the sequence.
    public var sum: Iterator.Element {
        return reduce(0, +)
    }
}

public extension RandomAccessCollection where Iterator.Element: BinaryInteger {
    /// Returns the arithmetic mean of all elements in the collection.
    public var arithmeticMean: Double {
        return isEmpty ? 0 : Double(Int64(sum)) / Double(Int64(count))
    }
    
    /// Returns the geometric mean of all elements in the collection.
    public var geometricMean: Double {
        return isEmpty ? 0 : pow(map({ Double(Int64($0)) }).reduce(1, *), 1 / Double(Int64(count)))
    }

    /// Returns the middle number in the collection, taken as the average of the two middle numbers when the collection has an even number of numbers.
    public var median: Double {
        guard !isEmpty else { return 0 }
        
        #if swift(>=4.1)
            let sort = sorted().compactMap { Int64($0) }
        #else
            let sort = sorted().flatMap { Int64($0) }
        #endif
        
        let count = Int(self.count)
        
        if count.isEven {
            return [Double(sort[count / 2 - 1]), Double(sort[count / 2])].arithmeticMean
        } else {
            return Double(sort[count / 2])
        }
    }
    
    /**
     Returns the variance of an entire population (σ²).
     
     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    public var variance: Double? {
        guard count >= 2 else { return nil }

        let arrayMean = arithmeticMean
        let elements = map { pow((Double(Int64($0)) - arrayMean), 2) }
        
        return elements.arithmeticMean
    }
    
    /**
     Returns the standard deviation (σ); a measure that is used to quantify the amount of variation or dispersion of a set of data values.
     
     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    public var standardDeviation: Double? {
        guard let variance = variance else { return nil }
        return sqrt(variance)
    }
}

public extension RandomAccessCollection where Iterator.Element: FloatingPoint {
    /// Returns the arithmetic mean of all elements in the collection.
    public var arithmeticMean: Iterator.Element {
        return isEmpty ? 0 : sum / Iterator.Element(Int64(count))
    }
    
    /// Returns the geometric mean of all elements in the collection.
    public var geometricMean: Double {
        return isEmpty ? 0 : pow((self as! [Double]).reduce(1.0, *), 1 / Double(Int64(count)))
    }

    /// Returns the middle number in the collection, taken as the average of the two middle numbers when the collection has an even number of numbers.
    public var median: Iterator.Element {
        let sort = sorted()
        let count = Int(Int64(self.count))

        if count.isEven {
            return [sort[count / 2 - 1], sort[count / 2]].arithmeticMean
        } else {
            return sort[count / 2]
        }
    }

    /**
     Returns the variance of an entire population (σ²).

     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    public var variance: Iterator.Element? {
        guard count >= 2 else { return nil }

        let arrayMean = arithmeticMean
        let elements = map { ($0 - arrayMean) * ($0 - arrayMean) }

        return elements.arithmeticMean
    }

    /**
     Returns the standard deviation (σ); a measure that is used to quantify the amount of variation or dispersion of a set of data values.

     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    public var standardDeviation: Iterator.Element? {
        guard let variance = variance else { return nil }
        return sqrt(variance)
    }
}
