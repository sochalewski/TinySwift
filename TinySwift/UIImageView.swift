//
//  UIImageView.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 06.05.2017.
//  Copyright © 2017 Piotr Sochalewski. All rights reserved.
//

import UIKit

#if !os(watchOS)
public extension UIImageView {
    
    /**
     Sets placeholder image and then downloads an image in asynchronous way using the `URLSession` and sets it as the current image.
     
     If the image from the URL to be retrieved is set correctly, the `success` parameter of the completion handler block is `true`. If the function fails, the `success` parameter is `false`.
     
     - parameter url: The URL to be retrieved.
     - parameter placeholder: The image to be set before sending the load request. If you pass `nil` then the current image would not be changed.
     - parameter completion: The completion handler to call when the load request is complete. This handler is executed on the main queue.
     */
    func setImage(from url: URL, placeholder placeholderImage: UIImage? = nil, completion: ((Bool) -> Void)? = nil) {
        if let placeholderImage = placeholderImage {
            image = placeholderImage
        }
        UIImage.get(from: url) { image in
            guard let image = image else { completion?(false); return }
            self.image = image
            completion?(true)
        }
    }
    
    /// Set the layer's magnification filter to the nearest neighbor interpolation filter, which is perfect for low resolution pixel-art, e.g. Quick Response codes.
    func sharpenForQRCode() {
        layer.magnificationFilter = .nearest
    }
}
#endif
