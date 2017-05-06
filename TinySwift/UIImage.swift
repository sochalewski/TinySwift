//
//  UIImage.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 25.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

import UIKit

public extension UIImage {
    /// Returns the image scaled to maximum 300 × 300 resolution.
    public var thumbnail: UIImage? {
        return resize(to: CGSize(width: 300.0, height: 300.0))
    }
    
    /// Returns the image with normalized orientation and scale.
    public var normalizedImage: UIImage? {
        guard imageOrientation != .up else { return self }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    /// Returns the data for the image in PNG format.
    public var png: Data? {
        return UIImagePNGRepresentation(self)
    }
    
    /**
     Returns the data for the image in JPEG format.
     
     - parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
     - returns: A data object containing the JPEG data, or `nil` if there was a problem generating the data. This function may return `nil` if the image has no data or if the underlying `CGImageRef` contains data in an unsupported bitmap format.
     */
    public func jpeg(quality: CGFloat = 1.0) -> Data? {
        return UIImageJPEGRepresentation(self, quality)
    }
    
    /**
     Creates a bitmap image using the data contained within a subregion of an existing bitmap image.
     
     - parameter bounds: A rectangle whose coordinates specify the area to create an image from.
     - returns: A UIImage object that specifies a subimage of the image. If the `rect` parameter defines an area that is not in the image, returns `nil`.
    */
    public func crop(to bounds: CGRect) -> UIImage? {
        guard let cgImage = cgImage, bounds.contains(bounds) else { return nil }
        return UIImage(cgImage: cgImage.cropping(to: bounds)!, scale: 0.0, orientation: imageOrientation)
    }
    
    /// Returns a square bitmap image cropping the sides.
    public var square: UIImage? {
        let size = CGSize(width: self.size.width * scale, height: self.size.height * scale)
        let shortest = min(size.width, size.height)
        let left: CGFloat = size.width > shortest ? (size.width - shortest) / 2.0 : 0.0
        let top: CGFloat = size.height > shortest ? (size.height - shortest) / 2.0 : 0.0
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let insetRect = rect.insetBy(dx: left, dy: top)
        
        return crop(to: insetRect)
    }
    
    #if !os(watchOS)
    /// Returns a copy of the image converted to grayscale.
    public var grayscale: UIImage? {
        guard let ciImage = CIImage(image: self) else { return nil }
        let grayscale = ciImage.applyingFilter("CIColorControls", withInputParameters: [kCIInputSaturationKey : 0.0])
        
        return UIImage(ciImage: grayscale)
    }
    #endif
    
    /**
     Returns a resized non-stretched copy of the image.
     
     - parameter size: The desired size of the image.
     - returns: A resized non-stretched UIImage object.
     */
    public func resize(to size: CGSize) -> UIImage? {
        guard let cgImage = cgImage else { return nil }

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
     Returns a copy of the image with a border.
     
     - parameter borderWidth: The desired width of the border.
     - parameter borderColor: The desired color of the border.
     - returns: A bordered UIImage object.
     */
    public func border(width borderWidth: CGFloat, color borderColor: UIColor) -> UIImage? {
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
    public func color(at point: CGPoint) -> UIColor? {
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
    public static func get(from url: URL, completion: @escaping (UIImage?) -> Void) {
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
