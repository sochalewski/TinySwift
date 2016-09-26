//
//  UIColor.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 26.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit

public extension UIColor {
    /**
     Initializes and returns a color object using the specified hexadecimal code and an optional alpha.
     
     - parameter hex: The hexadecimal code starting with or without `#` with 3 or 6 signs (no alpha channel information) and 4 or 8 signs (w/ alpha channel information)
     - parameter alpha: The opacity value of the color object, specified as a value from 0.0 to 1.0. Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0. When `hex` contains information about alpha channel this parameter is unused. When function requires `alpha` and is called without this parameter, then 1.0 is used as a default value.
     - returns: The color object. The color information represented by this object is in an RGB colorspace. On applications linked for iOS 10 or later, the color is specified in an extended range sRGB color space. On earlier versions of iOS, the color is specified in a device RGB colorspace.
     */
    public convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexCode = hex.trimmed
        while hexCode.contains("#") {
            hexCode.remove(at: hexCode.range(of: "#")!.lowerBound)
        }
        
        var hexInt: UInt32 = 0
        let scanner = Scanner(string: hexCode)
        if !scanner.scanHexInt32(&hexInt) {
            return nil
        }
        
        var divisor: CGFloat!
        var red, green, blue: CGFloat!
        var alphaChannel: CGFloat?
        
        switch hexCode.characters.count {
        case 3, 4:
            divisor = 15
        case 6, 8:
            divisor = 255
        default:
            return nil
        }
        
        switch hexCode.characters.count {
        case 3:
            red = CGFloat((UInt16(hexInt) & 0xF00) >> 8) / divisor
            green = CGFloat((UInt16(hexInt) & 0x0F0) >> 4) / divisor
            blue = CGFloat(UInt16(hexInt) & 0x00F) / divisor
        case 4:
            red = CGFloat((UInt16(hexInt) & 0xF000) >> 12) / divisor
            green = CGFloat((UInt16(hexInt) & 0x0F00) >> 8) / divisor
            blue = CGFloat((UInt16(hexInt) & 0x00F0) >> 4) / divisor
            alphaChannel = CGFloat(UInt16(hexInt) & 0x000F) / divisor
        case 6:
            red = CGFloat((hexInt & 0xFF0000) >> 16) / divisor
            green = CGFloat((hexInt & 0x00FF00) >> 8) / divisor
            blue = CGFloat(hexInt & 0x0000FF) / divisor
        case 8:
            red = CGFloat((hexInt & 0xFF000000) >> 24) / divisor
            green = CGFloat((hexInt & 0x00FF0000) >> 16) / divisor
            blue = CGFloat((hexInt & 0x0000FF00) >> 8) / divisor
            alphaChannel = CGFloat(hexInt & 0x000000FF) / divisor
        default:
            ()
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alphaChannel ?? alpha)
    }
}
