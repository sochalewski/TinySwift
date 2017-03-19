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
    fileprivate subscript(safeOptional index: Int) -> Element {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            guard indices.contains(index) else { return }
            self[index] = newValue
        }
    }
}

public extension Array where Element: Any {
    /**
     Accesses the element at the specified position in a safe way.
     
     - parameter index: The position of the element to access. `index` **may or may not** be greater than or equal to `startIndex` and less than `endIndex`, because elements are accessed in a safe way.
     */
    public subscript(safe index: Int) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            guard indices.contains(index) else { return }
            
            if let newValue = newValue {
                self[index] = newValue
                return
            }
            
            let isElementOptional = String(describing: Element.self).hasPrefix("Optional<") // ugh
            guard isElementOptional else { fatalError("nil cannot be assigned to type '\(String(describing: Element.self))'") }
            var selfOfOptionals = self as Array<Optional<Any>>
            selfOfOptionals[safeOptional: index] = newValue
            self = selfOfOptionals as! [Element]
        }
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
    public var random: Iterator.Element? {
        guard !isEmpty else { return nil }
        let index = self.index(startIndex, offsetBy: Int(arc4random_uniform(UInt32(count))))
        
        return self[index]
    }
}

public extension Collection where Index == Int {
    /// Returns a randomized element from the collection.
    public var random: Iterator.Element? {
        guard !isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(endIndex - startIndex)))
        
        return self[index]
    }
    
    #if !os(watchOS)
        /// Shuffles the objects in the collection. The objects in the collection are shuffled based on a Fisher-Yates shuffle.
        @available(iOS 9.0, tvOS 9.0, *)
        public mutating func shuffle() {
            self = GKARC4RandomSource.sharedRandom().arrayByShufflingObjects(in: self as! [Any]) as! Self
        }
        
        /// Returns a shuffled instance of the collection. The objects in the collection are shuffled based on a Fisher-Yates shuffle.
        @available(iOS 9.0, tvOS 9.0, *)
        public var shuffled: [Iterator.Element] {
            var array = Array(self)
            array.shuffle()
            
            return array
        }
    #endif
}

extension Collection where Iterator.Element: Hashable {
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
        
        let sortedAppearances = Array(appearances.keys).sorted(by: { appearances[$0]! > appearances[$1]! })
        guard sortedAppearances.count != 1 else { return sortedAppearances.first }
        
        return appearances[sortedAppearances[0]]! > appearances[sortedAppearances[1]]! ? sortedAppearances[0] : nil
    }
}

public extension Collection where Index == Int, Iterator.Element: Hashable {
    /// A Boolean value that determines whether all elements of the collection are equal.
    public var areAllElementsEqual: Bool {
        guard !isEmpty else { return true }
        return !Array(self).dropFirst().contains { $0 != first! }
    }
}

public extension Collection where Iterator.Element: Integer {
    /// Returns the sum of all elements in the collection.
    public var sum: Iterator.Element {
        return reduce(0, +)
    }
}

public extension Collection where Iterator.Element: Integer, Index == Int {
    /// Returns the arithmetic mean of all elements in the collection.
    public var arithmeticMean: Double {
        return isEmpty ? 0 : Double(sum.toIntMax()) / Double(endIndex - startIndex)
    }
    
    /// Returns the geometric mean of all elements in the collection.
    public var geometricMean: Double {
        return isEmpty ? 0 : pow(map({ Double($0.toIntMax()) }).reduce(1, *), 1 / Double(endIndex - startIndex))
    }
    
    /// Returns the middle number in the collection, taken as the average of the two middle numbers when the collection has an even number of numbers.
    public var median: Double {
        guard !isEmpty else { return 0 }
        let count = Int(endIndex - startIndex)
        let isCountEven = count % 2 == 0
        let sort = sorted()
        
        if isCountEven {
            return [sort[(count / 2) - 1].toIntMax(), sort[count / 2].toIntMax()].arithmeticMean
        } else {
            return Double(sort[count / 2].toIntMax())
        }
    }
    
    /**
     Returns the variance of an entire population (σ²).
     
     If the number of elements in the collection is lower than or equal to 1, the value of the property is `nil`.
     */
    public var variance: Double? {
        guard count >= 2 else { return nil }

        let arrayMean = arithmeticMean
        let elements = map { pow((Double($0.toIntMax()) - arrayMean), 2) }
        
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

public extension Collection where Iterator.Element: FloatingPoint {
    /// Returns the sum of all elements in the collection.
    public var sum: Iterator.Element {
        return reduce(0, +)
    }
}

public extension Collection where Iterator.Element: FloatingPoint, Index == Int {
    /// Returns the arithmetic mean of all elements in the collection.
    public var arithmeticMean: Iterator.Element {
        return isEmpty ? 0 : sum / Iterator.Element(endIndex - startIndex)
    }
    
    /// Returns the geometric mean of all elements in the collection.
    public var geometricMean: Double {
        return isEmpty ? 0 : pow((self as! [Double]).reduce(1.0, *), 1 / Double(endIndex - startIndex))
    }
    
    /// Returns the middle number in the collection, taken as the average of the two middle numbers when the collection has an even number of numbers.
    public var median: Iterator.Element {
        guard !isEmpty else { return 0 }
        let count = Int(endIndex - startIndex)
        let isCountEven = count % 2 == 0
        let sort = sorted()
        
        if isCountEven {
            return [sort[(count / 2) - 1], sort[count / 2]].arithmeticMean
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
