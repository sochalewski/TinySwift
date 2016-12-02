//
//  NSLocalizedStringFunction.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 02.12.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

/**
 Returns a localized version of a string.
 
 - parameter key: The key for a string in the default table.
 - returns: Returns a localized string, using the main bundle.
 */
public func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
