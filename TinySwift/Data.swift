//
//  Data.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 09.11.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit

/// QR Code Error Correction Capability.
public enum QRCodeCorrectionLevel: String {
    /// 7% of data bytes can be restored.
    case low = "L"
    /// 15% of data bytes can be restored.
    case medium = "M"
    /// 25% of data bytes can be restored.
    case quartile = "Q"
    /// 30% of data bytes can be restored.
    case high = "H"
}

public extension Data {
    /// Returns a hexadecimal encoded String.
    var hexadecimalString: String {
        return map { String(format: "%02x", $0) }.joined(separator: "")
    }
    
    /**
     Initialize a `Data` from the hexadecimal string representation.
     
     Sample usage:
     
         let hexString = "48656c6c6f"
         let data = Data(hexadecimalString: hexString)
         // data is now <48656c6c6f>
     
     - parameter string: The hexadecimal string representation.
     - note: If the string has any non-hexadecimal characters, those are ignored and only hexadecimal characters are processed.
     - returns: The data represented by the hexadecimal string or `nil` if a data cannot be created.
    */
    init?(hexadecimalString string: String) {
        var data = Data(capacity: string.count / 2)
        
        let regex = try? NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex?.enumerateMatches(in: string, options: [], range: NSMakeRange(0, string.count)) { match, flags, stop in
            let byteString = (string as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }
        
        guard data.count > 0 else { return nil }
        
        self = data
    }
    
    #if !os(watchOS)
    /// Generates a Quick Response code (two-dimensional barcode) from the data.
    /// - Parameter correctionLevel: A desired QR code error correction capability. Default value is medium (`M`).
    /// - Returns: A Quick Response code (two-dimensional barcode) from the data or `nil` if a QR code cannot be created.
    func qrCode(correctionLevel: QRCodeCorrectionLevel = .medium) -> UIImage? {
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        filter.setValue(self, forKey: "inputMessage")
        filter.setValue(correctionLevel.rawValue, forKey: "inputCorrectionLevel")
        
        guard let output = filter.outputImage else { return nil }
        
        return UIImage(ciImage: output)
    }
    #endif
}
