//
//  AVAsset.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 25.09.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

#if !os(watchOS)
    import AVFoundation

    public extension AVAsset {
        /// Returns an image generated from the first frame of the given asset.
        var thumbnail: UIImage? {
            let thumbnailGenerator = AVAssetImageGenerator(asset: self)
            thumbnailGenerator.appliesPreferredTrackTransform = true
            var time = duration
            time.value = 0
            guard let imageRef = try? thumbnailGenerator.copyCGImage(at: time, actualTime: nil) else { return nil }
            
            return UIImage(cgImage: imageRef)
        }
    }
#endif
