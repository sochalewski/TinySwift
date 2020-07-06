//
//  WKInterfaceDevice.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 30.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

#if os(watchOS)
    import WatchKit

    /// The Apple Watch device type representation based on a case size.
    public enum WatchDeviceType: Int, Equatable, Comparable {
        /// An unknown Apple Watch case size.
        case unknown
        /// The Apple Watch 38 mm case size.
        case watch38mm
        /// The Apple Watch 40 mm case size.
        case watch40mm
        /// The Apple Watch 42 mm case size.
        case watch42mm
        /// The Apple Watch 44 mm case size.
        case watch44mm
    }

    #if swift(>=4.2)
    extension WatchDeviceType: CaseIterable {}
    #endif
    
    public func <(lhs: WatchDeviceType, rhs: WatchDeviceType) -> Bool { return lhs.rawValue < rhs.rawValue }

    @available(iOS 8.2, watchOS 2.0, *)
    public extension WKInterfaceDevice {
        /// A Boolean value that determines whether the Apple watch case size equals 38 or 40 mm.
        var isSmaller: Bool {
            return device == .watch38mm || device == .watch40mm
        }
        
        /// A Boolean value that determines whether the Apple watch case size equals 42 or 44 mm.
        var isLarger: Bool {
            return device == .watch42mm || device == .watch44mm
        }
        
        /// Returns a current Apple Watch device type based on a case size.
        var device: WatchDeviceType {
            let watch38mm = CGRect(origin: .zero, size: CGSize(width: 136.0, height: 170.0))
            let watch40mm = CGRect(origin: .zero, size: CGSize(width: 162.0, height: 197.0))
            let watch42mm = CGRect(origin: .zero, size: CGSize(width: 156.0, height: 195.0))
            let watch44mm = CGRect(origin: .zero, size: CGSize(width: 184.0, height: 224.0))
            
            let currentBounds = WKInterfaceDevice.current().screenBounds
            
            switch currentBounds {
            case watch38mm: return .watch38mm
            case watch40mm: return .watch40mm
            case watch42mm: return .watch42mm
            case watch44mm: return .watch44mm
            default: return .unknown
            }
        }
    }
#endif
