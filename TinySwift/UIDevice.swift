//
//  UIDevice.swift
//  TinySwift
//
//  Created by Piotr Sochalewski on 30.10.2016.
//  Copyright © 2016 Piotr Sochalewski. All rights reserved.
//

#if !os(watchOS)

    import UIKit

    /// The device type representation.
    public enum DeviceType: Equatable {
        /// The iPhone device type.
        case phone(model: PhoneModel)
        /// The iPad device type.
        case pad(model: PadModel)
        /// The iPod touch device type.
        case pod(model: PodModel)
        /// The Apple TV device type.
        case tv(model: TVModel)
        /// The simulator based device type.
        case simulator
        /// An unknown device type.
        case unknown
    }

    /// The iPhone device type representation.
    public enum PhoneModel: Int, Equatable, Comparable {
        /// An unknown iPhone model.
        case unknown
        /// The first iPhone.
        case iPhone
        /// The iPhone 3G.
        case iPhone3G
        /// The iPhone 3GS.
        case iPhone3GS
        /// The iPhone 4.
        case iPhone4
        /// The iPhone 4s.
        case iPhone4s
        /// The iPhone 5.
        case iPhone5
        /// The iPhone 5c.
        case iPhone5c
        /// The iPhone 5s.
        case iPhone5s
        /// The iPhone 36.
        case iPhone6
        /// The iPhone 6 Plus.
        case iPhone6Plus
        /// The iPhone 6s.
        case iPhone6s
        /// The iPhone 6s Plus.
        case iPhone6sPlus
        /// The iPhone SE.
        case iPhoneSE
        /// The iPhone 7.
        case iPhone7
        /// The iPhone 7 Plus.
        case iPhone7Plus
        /// The iPhone 8.
        case iPhone8
        /// The iPhone 8 Plus.
        case iPhone8Plus
        /// The iPhone X.
        case iPhoneX
    }

    /// The iPad device type representation.
    public enum PadModel: Equatable {
        /// An unknown iPad model.
        case unknown
        /// The first iPad.
        case iPad1
        /// The iPad 2.
        case iPad2
        /// The iPad 3.
        case iPad3
        /// The iPad 4.
        case iPad4
        /// The iPad 5.
        case iPad5
        /// The first iPad Air.
        case iPadAir
        /// The iPad Air 2.
        case iPadAir2
        /// The first iPad mini.
        case iPadMini
        /// The iPad mini 2.
        case iPadMini2
        /// The iPad mini 3.
        case iPadMini3
        /// The iPad mini 4.
        case iPadMini4
        /// The iPad Pro.
        case iPadPro(size: ScreenSize)
    }

    /// The iPod touch device type representation.
    public enum PodModel: Int, Equatable, Comparable {
        /// An unknown iPod touch model.
        case unknown
        /// The first generation of iPod touch.
        case touch1g
        /// The second generation of iPod touch.
        case touch2g
        /// The third generation of iPod touch.
        case touch3g
        /// The fourth generation of iPod touch.
        case touch4g
        /// The fifth generation of iPod touch.
        case touch5g
        /// The sixth generation of iPod touch.
        case touch6g
    }

    /// The Apple TV device type representation.
    public enum TVModel: Int, Equatable, Comparable {
        /// An unknown Apple TV model.
        case unknown
        /// The fourth generation of Apple TV.
        case tv4g
        /// The Apple TV 4K.
        case tv4k
    }
    
    public func ==(lhs: DeviceType, rhs: DeviceType) -> Bool {
        switch (lhs, rhs) {
        case (.phone(let model1), .phone(let model2)): return model1 == model2
        case (.pad(let model1), .pad(let model2)): return model1 == model2
        case (.pod(let model1), .pod(let model2)): return model1 == model2
        case (.tv(let model1), .tv(let model2)): return model1 == model2
        case (.simulator, .simulator): return true
        case (.unknown, .unknown): return true
        default: return false
        }
    }
    
    public func ==(lhs: PadModel, rhs: PadModel) -> Bool { return lhs == rhs }
    
    public func <(lhs: PhoneModel, rhs: PhoneModel) -> Bool { return lhs.rawValue < rhs.rawValue }
    public func <(lhs: PodModel, rhs: PodModel) -> Bool { return lhs.rawValue < rhs.rawValue }
    public func <(lhs: TVModel, rhs: TVModel) -> Bool { return lhs.rawValue < rhs.rawValue }

    public extension UIDevice {
        /// Returns a string containing the device code.
        public var deviceCode: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            
            return String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        }
        
        /// Returns the device type.
        public var device: DeviceType {
            switch deviceCode {
            case "iPhone1,1": return .phone(model: .iPhone)
            case "iPhone1,2": return .phone(model: .iPhone3G)
            case "iPhone2,1": return .phone(model: .iPhone3GS)
            case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .phone(model: .iPhone4)
            case "iPhone4,1", "iPhone4,2", "iPhone4,3": return .phone(model: .iPhone4s)
            case "iPhone5,1", "iPhone5,2": return .phone(model: .iPhone5)
            case "iPhone5,3", "iPhone5,4": return .phone(model: .iPhone5c)
            case "iPhone6,1", "iPhone6,2": return .phone(model: .iPhone5s)
            case "iPhone7,2": return .phone(model: .iPhone6)
            case "iPhone7,1": return .phone(model: .iPhone6Plus)
            case "iPhone8,1": return .phone(model: .iPhone6s)
            case "iPhone8,2": return .phone(model: .iPhone6sPlus)
            case "iPhone8,4": return .phone(model: .iPhoneSE)
            case "iPhone9,1", "iPhone9,3": return .phone(model: .iPhone7)
            case "iPhone9,2", "iPhone9,4": return .phone(model: .iPhone7Plus)
            case "iPhone10,1", "iPhone10,4": return .phone(model: .iPhone8)
            case "iPhone10,2", "iPhone10,5": return .phone(model: .iPhone8Plus)
            case "iPhone10,3", "iPhone10,6": return .phone(model: .iPhoneX)
                
            case "iPad1,1": return .pad(model: .iPad1)
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .pad(model: .iPad2)
            case "iPad3,1", "iPad3,2", "iPad3,3": return .pad(model: .iPad3)
            case "iPad3,4", "iPad3,5", "iPad3,6": return .pad(model: .iPad4)
            case "iPad4,1", "iPad4,2", "iPad4,3": return .pad(model: .iPadAir)
            case "iPad5,3", "iPad5,4": return .pad(model: .iPadAir2)
            case "iPad2,5", "iPad2,6", "iPad2,7": return .pad(model: .iPadMini)
            case "iPad4,4", "iPad4,5", "iPad4,6": return .pad(model: .iPadMini2)
            case "iPad4,7", "iPad4,8", "iPad4,9": return .pad(model: .iPadMini3)
            case "iPad5,1", "iPad5,2": return .pad(model: .iPadMini4)
            case "iPad6,3", "iPad6,4": return .pad(model: .iPadPro(size: .inch9p7))
            case "iPad6,7", "iPad6,8": return .pad(model: .iPadPro(size: .inch12p9))
            case "iPad6,11", "iPad6,12": return .pad(model: .iPad5)
                
            case "iPod1,1": return .pod(model: .touch1g)
            case "iPod2,1": return .pod(model: .touch2g)
            case "iPod3,1": return .pod(model: .touch3g)
            case "iPod4,1": return .pod(model: .touch4g)
            case "iPod5,1": return .pod(model: .touch5g)
            case "iPod7,1": return .pod(model: .touch6g)
            
            case "AppleTV5,3": return .tv(model: .tv4g)
            case "AppleTV6,2": return .tv(model: .tv4k)
                
            case "i386", "x86_64": return .simulator
                
            default:
                if deviceCode.contains("iPhone") { return .phone(model: .unknown) }
                else if deviceCode.contains("iPad") { return .pad(model: .unknown) }
                else if deviceCode.contains("iPod") { return .pod(model: .unknown) }
                else if deviceCode.contains("AppleTV") { return .tv(model: .unknown) }
                else { return .unknown }
            }
        }
    }

#endif
