//
//  UIScreen.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 26.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit

#if !os(watchOS)
    
    /// The display diagonal screen size representation.
    public enum ScreenSize: Int, Equatable, Comparable {
        /// An unknown screen size.
        case unknown
        /// The 3.5" screen size.
        case inch3p5
        /// The 4.0" screen size.
        case inch4
        /// The 4.7" screen size.
        case inch4p7
        /// The 5.5" screen size.
        case inch5p5
        /// The 5.8" screen size.
        case inch5p8
		/// The 6.1" screen size.
		case inch6p1
		/// The 6.5" screen size.
		case inch6p5
        /// The 7.9" screen size.
        case inch7p9
        /// The 9.7" screen size.
        case inch9p7
        /// The 10.5" screen size.
        case inch10p5
        /// The 11.0" screen size.
        case inch11
        /// The 12.9" screen size.
        case inch12p9
    }

    public func <(lhs: ScreenSize, rhs: ScreenSize) -> Bool { return lhs.rawValue < rhs.rawValue }

    #if swift(>=4.2)
    extension ScreenSize: CaseIterable {}
    #endif

    public extension UIScreen {
        #if os(iOS)
        /// Returns the display diagonal screen size.
        public var size: ScreenSize {
            let height = max(bounds.width, bounds.height)
            
            switch height {
            case 480: return .inch3p5
            case 568: return .inch4
			case 667: return scale == 3.0 ? .inch5p5 : .inch4p7
            case 736: return .inch5p5
            case 812: return .inch5p8
			case 896: return scale == 3.0 ? .inch6p5 : .inch6p1
            case 1024:
                switch UIDevice.current.device {
				case .pad(.iPadMini), .pad(.iPadMini2), .pad(.iPadMini3), .pad(.iPadMini4):
                    return .inch7p9
				case .pad(.iPadPro(.inch10p5)), .pad(.iPadPro2(.inch10p5)):
					return .inch10p5
                default:
                    return .inch9p7
                }
            case 1112: return .inch10p5
            case 1194: return .inch11
            case 1366: return .inch12p9
            default: return .unknown
            }
        }
        
        /// A Boolean value that determines whether the display diagonal screen size equals 3.5" for iPhones (iPhone 4s and older) or 7.9" for iPads (iPad mini).
        public var isSmallScreen: Bool {
            return [ScreenSize.inch3p5, ScreenSize.inch7p9].contains(size)
        }
        #endif
        
        #if os(tvOS)
        /// A Boolean value that determines whether the display screen resolution is equal or lower than 720p.
        public var isLowResolution: Bool {
            return min(bounds.width, bounds.height) <= 720.0
        }
        #endif
    }

#endif
