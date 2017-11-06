//
//  NSLocalizedStringFunction.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 02.12.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Deprecated in favor of String.localized")
public func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}
