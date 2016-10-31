//
//  WKInterfaceDevice.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 30.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

#if !os(tvOS)

    import Foundation
    import WatchKit

    /// The Apple Watch device type based on a case size.
    public enum WatchDeviceType: Int, Equatable, Comparable {
        /// An unknown Apple Watch case size.
        case unknown
        /// The Apple Watch 38 mm case size.
        case watch38mm
        /// The Apple Watch 42 mm case size.
        case watch42mm
    }
    
    public func ==(lhs: WatchDeviceType, rhs: WatchDeviceType) -> Bool { return lhs == rhs }
    public func <(lhs: WatchDeviceType, rhs: WatchDeviceType) -> Bool { return lhs.rawValue < rhs.rawValue }

    @available(iOS 8.2, watchOS 2.0, *)
    public extension WKInterfaceDevice {
        /// A Boolean value that determines whether the Apple watch case size equals 38 mm.
        public var is38mm: Bool {
            return device == .watch38mm
        }
        
        /// A Boolean value that determines whether the Apple watch case size equals 42 mm.
        public var is42mm: Bool {
            return device == .watch42mm
        }
        
        /// Returns a current Apple Watch device type based on a case size.
        public var device: WatchDeviceType {
            let watch38mm = CGRect(origin: .zero, size: CGSize(width: 136.0, height: 170.0))
            let watch42mm = CGRect(origin: .zero, size: CGSize(width: 156.0, height: 195.0))
            
            let currentBounds = WKInterfaceDevice.current().screenBounds
            
            switch currentBounds {
            case watch38mm: return .watch38mm
            case watch42mm: return .watch42mm
            default: return .unknown
            }
        }
    }

#endif
