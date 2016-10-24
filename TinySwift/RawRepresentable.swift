//
//  RawRepresentable.swift
//  Pods
//
//  Created by Piotr Sochalewski on 24.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

public extension RawRepresentable where Self: Hashable {
    fileprivate static func iterate() -> AnyIterator<Self> {
        var i = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) {
                $0.withMemoryRebound(to: Self.self, capacity: 1) { $0.pointee }
            }
            
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
    
    /// Returns an unordered collection of `RawRepresentable` conforming to `Hashable` cases or options.
    public static var all: Set<Self> {
        return Set(iterate())
    }
}
