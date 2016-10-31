//
//  UIScreen.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 26.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit

#if !os(watchOS)

    public extension UIScreen {
        #if os(iOS)
            /// A Boolean value that determines whether the device height is equal or lower than 480 multiplied by `scale` (iPhone 4s and older).
            public var isSmallScreen: Bool {
                return nativeBounds.size.height <= 480.0 * scale
            }
            
            /// A Boolean value that determines whether the device is iPad and its height is equal or greater than 1366 multiplied by `scale` (i.e. iPad Pro 13").
            public var isPad13OrBigger: Bool {
                return UIDevice.current.userInterfaceIdiom == .pad && nativeBounds.size.height >= 1366.0 * scale
            }
        #endif
    }

#endif
