//
//  UIScreen.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 26.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit

#if !os(watchOS)
    
    #if os(iOS)
        /// The display diagonal screen size representation.
        public enum ScreenSize: Int, Equatable, Comparable {
            /// An unknown screen size.
            case unknown
            /// The 3.5" screen size.
            case size3p5In
            /// The 4.0" screen size.
            case size4In
            /// The 4.7" screen size.
            case size4p7In
            /// The 5.5" screen size.
            case size5p5In
            /// The 7.9" screen size.
            case size7p9In
            /// The 9.7" screen size.
            case size9p7In
            /// The 12.9" screen size.
            case size12p9In
        }

        public func <(lhs: ScreenSize, rhs: ScreenSize) -> Bool { return lhs.rawValue < rhs.rawValue }
    #endif

    public extension UIScreen {
        #if os(iOS)
        /// Returns the display diagonal screen size.
        public var size: ScreenSize {
            let height = max(bounds.width, bounds.height)
            
            switch height {
            case 480: return .size3p5In
            case 568: return .size4In
            case 667: return .size4p7In
            case 736: return .size5p5In
            case 1024:
                switch UIDevice.current.device {
                case .pad(model: .iPadMini), .pad(model: .iPadMini2), .pad(model: .iPadMini3), .pad(model: .iPadMini4):
                    return .size7p9In
                default:
                    return .size9p7In
                }
            case 1366: return .size12p9In
            default: return .unknown
            }
        }
        
        /// A Boolean value that determines whether the device screen size is 3.5" for iPhones (iPhone 4s and older) or 7.9" for iPads (iPad mini).
        public var isSmallScreen: Bool {
            return [ScreenSize.size3p5In, ScreenSize.size7p9In].contains(size)
        }
        #endif
    }

#endif
