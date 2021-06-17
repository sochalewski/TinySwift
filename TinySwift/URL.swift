//
//  URL.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 15/06/2021.
//

import UIKit

public extension URL {
    
    #if !os(watchOS)
    /// Generates a Quick Response code (two-dimensional barcode) from the URL.
    /// - Parameter correctionLevel: A desired QR code error correction capability. Default value is medium (`M`).
    /// - Parameter encoding: A URL encoding. Default value is ISO Latin 1.
    /// - Returns: A Quick Response code (two-dimensional barcode) from the URL or `nil` if a QR code cannot be created.
    func qrCode(
        correctionLevel: QRCodeCorrectionLevel = .medium,
        encoding: String.Encoding = .isoLatin1
    ) -> UIImage? {
        absoluteString.data(using: encoding)?.qrCode(correctionLevel: correctionLevel)
    }
    #endif
}
