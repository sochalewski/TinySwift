//
//  CGAffineTransform.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 10.02.2017.
//  Copyright © 2017 Piotr Sochalewski. All rights reserved.
//

import CoreGraphics

public extension CGAffineTransform {
    /// The factor by which the x-axis of the coordinate system is scaled.
    public var scaleX: CGFloat {
        return sqrt(a * a + c * c)
    }
    
    /// The factor by which the y-axis of the coordinate system is scaled.
    public var scaleY: CGFloat {
        return sqrt(b * b + d * d)
    }
    
    /// The angle, in radians, by which the matrix rotates the coordinate system axes.
    public var rotationAngle: CGFloat {
        return CGFloat(atan2f(Float(b), Float(a)))
    }
}
