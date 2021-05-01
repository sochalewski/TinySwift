//
//  UIImage.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 25.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit
#if !os(watchOS)
import AVFoundation
#endif

public extension UIImage {
    
    /**
     Initializes and returns an image object filled with the specified color
     
     - parameter color: The color to fill the image.
     - parameter size: The size of the created image. When function requires `size` and is called without this parameter, then `(1.0, 1.0)` is used as a default value.
     - returns: An initialized `UIImage` object, or `nil` if the method could not initialize the image from the specified data.
     */
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        UIGraphicsEndImageContext()
        
        self.init(cgImage: image)
    }
    
    /// Returns the image scaled to maximum 300 × 300 resolution.
    var thumbnail: UIImage? {
        return resize(to: CGSize(width: 300.0, height: 300.0))
    }
    
    /// Returns the image with normalized orientation and scale.
    var normalizedImage: UIImage? {
        guard imageOrientation != .up else { return self }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    /// Returns the data for the image in PNG format.
    @available(swift, deprecated: 4.2, message: "Deprecated in favor of UIImage.pngData().")
    var png: Data? {
        #if swift(>=4.2)
        return pngData()
        #else
        return UIImagePNGRepresentation(self)
        #endif
    }
    
    /**
     Returns the data for the image in JPEG format.
     
     - parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
     - returns: A data object containing the JPEG data, or `nil` if there was a problem generating the data. This function may return `nil` if the image has no data or if the underlying `CGImageRef` contains data in an unsupported bitmap format.
     */
    @available(swift, deprecated: 4.2, message: "Deprecated in favor of UIImage.jpegData(compressionQuality:).")
    func jpeg(quality: CGFloat = 1.0) -> Data? {
        #if swift(>=4.2)
        return jpegData(compressionQuality: quality)
        #else
        return UIImageJPEGRepresentation(self, quality)
        #endif
    }
    
    #if !os(watchOS)
    /**
     Returns the data for the image in HEIC format.
     
     - parameter quality: The quality of the resulting HEIC image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
     - returns: A data object containing the HEIC data, or `nil` if there was a problem generating the data. This function may return `nil` if the image has no data, if the underlying `CGImageRef` contains data in an unsupported bitmap format or if the function is executed on iOS simulator.
     */
    @available(iOS 11.0, tvOS 11.0, *)
    func heic(quality: CGFloat = 1.0) -> Data? {
        let destinationData = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(destinationData, AVFileType.heic as CFString, 1, nil), let cgImage = cgImage else { return nil }
        
        let options = [kCGImageDestinationLossyCompressionQuality: quality]
        CGImageDestinationAddImage(destination, cgImage, options as CFDictionary)
        CGImageDestinationFinalize(destination)
        
        return destinationData as Data
    }
    #endif
    
    /**
     Creates a bitmap image using the data contained within a subregion of an existing bitmap image.
     
     - parameter bounds: A rectangle whose coordinates specify the area to create an image from.
     - returns: A UIImage object that specifies a subimage of the image. If the `rect` parameter defines an area that is not in the image, returns `nil`.
    */
    func crop(to bounds: CGRect) -> UIImage? {
        guard let cgImage = normalizedImage?.cgImage, bounds.contains(bounds) else { return nil }
        return UIImage(cgImage: cgImage.cropping(to: bounds)!)
    }
    
    /// Returns a square bitmap image cropping the sides.
    var square: UIImage? {
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        let shortest = min(size.width, size.height)
        let left: CGFloat = round(size.width > shortest ? (size.width - shortest) / 2.0 : 0.0)
        let top: CGFloat = round(size.height > shortest ? (size.height - shortest) / 2.0 : 0.0)
        let rect = CGRect(x: 0, y: 0, width: shortest, height: shortest)
        let insetRect = rect.offsetBy(dx: left, dy: top)

        return crop(to: insetRect)
    }
    
    #if !os(watchOS)
    /// Returns a copy of the image converted to grayscale.
    var grayscale: UIImage? {
        guard let ciImage = CIImage(image: self) else { return nil }
        #if swift(>=4.0)
        let grayscale = ciImage.applyingFilter("CIColorControls", parameters: [kCIInputSaturationKey : 0.0])
        #else
        let grayscale = ciImage.applyingFilter("CIColorControls", withInputParameters: [kCIInputSaturationKey : 0.0])
        #endif
        
        return UIImage(ciImage: grayscale)
    }
    #endif
    
    /**
     Returns a resized non-stretched copy of the image.
     
     - parameter size: The desired size of the image.
     - returns: A resized non-stretched UIImage object.
     */
    func resize(to size: CGSize) -> UIImage? {
        #if !os(watchOS)
        if #available(iOS 10.0, tvOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: size)
            
            return renderer.image { _ in
                draw(in: CGRect(origin: .zero, size: size))
            }
        }
        #endif
        
        guard let cgImage = cgImage else { return nil }
        guard min(self.size.width, self.size.height) > 0.0 else { return nil }
        
        let horizontalRatio = size.width / self.size.width
        let verticalRatio = size.height / self.size.height
        let ratio = min(horizontalRatio, verticalRatio)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width * ratio, height: self.size.height * ratio)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        guard let context = CGContext(data: nil, width: Int(rect.size.width), height: Int(rect.size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else { return nil }
        let transform = CGAffineTransform.identity
        
        context.concatenate(transform)
        context.interpolationQuality = .medium
        context.draw(cgImage, in: rect)
        
        guard let coreImage = context.makeImage() else { return nil }
        
        return UIImage(cgImage: coreImage, scale: scale, orientation: imageOrientation)
    }
    
    /**
     Returns a resized non-stretched copy of the image.
     
     - parameter shorterSide: The desired shorter side length of the image.
     - returns: A resized non-stretched UIImage object.
     */
    func resize(to shorterSide: CGFloat) -> UIImage? {
        let currentShorterSide = min(self.size.height, self.size.width)
        guard currentShorterSide > 0.0 else { return nil }
        let scale = shorterSide / currentShorterSide
        let size = self.size.applying(CGAffineTransform(scaleX: scale, y: scale))
        
        return resize(to: size)
    }
    
    /**
     Returns a copy of the image with a border.
     
     - parameter borderWidth: The desired width of the border.
     - parameter borderColor: The desired color of the border.
     - returns: A bordered UIImage object.
     */
    func border(width borderWidth: CGFloat, color borderColor: UIColor) -> UIImage? {
        guard let cgImage = cgImage else { return nil }

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let width = cgImage.width
        let height = cgImage.height
        let bits = cgImage.bitsPerComponent
        let colorSpace = cgImage.colorSpace
        let bitmapInfo = cgImage.bitmapInfo
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bits, bytesPerRow: 0, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue) else { return nil }
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        
        borderColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        context.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
        context.setLineWidth(borderWidth)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width * scale, height: size.height * scale)
        let inset = rect.insetBy(dx: borderWidth * scale / 2.0, dy: borderWidth * scale / 2.0)
        
        context.stroke(rect)
        context.draw(cgImage, in: inset)
        
        guard let coreImage = context.makeImage() else { return nil }
        UIGraphicsEndImageContext()

        return UIImage(cgImage: coreImage)
    }
    
    /**
     Returns a color of the given point.
     
     - parameter point: The point to get color with.
     - returns: A UIColor object.
     */
    func color(at point: CGPoint) -> UIColor? {
        guard let dataProvider = cgImage?.dataProvider, let data = CFDataGetBytePtr(dataProvider.data) else { return nil }
        
        let pixelInfo = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / 255.0
        let g = CGFloat(data[pixelInfo+1]) / 255.0
        let b = CGFloat(data[pixelInfo+2]) / 255.0
        let a = CGFloat(data[pixelInfo+3]) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    /**
     Gets an image in asynchronous way using the `URLSession` for downloading the content.
     
     If the request completes successfully and the request's data is formatted to match the file format of one of the system’s supported image types, the `image` parameter of the completion handler block contains the image. If the request fails or the request's data is not formatted to match the file format of one of the system’s supported image types, the `image` parameter is nil.
     
     - parameter url: The URL to be retrieved.
     - parameter completion: The completion handler to call when the load request is complete. This handler is executed on the main queue.
     */
    static func get(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            var image: UIImage?
            if let data = data {
                image = UIImage(data: data)
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
            .resume()
    }
}
