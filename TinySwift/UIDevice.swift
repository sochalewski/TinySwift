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
        case phone(PhoneModel)
        /// The iPad device type.
        case pad(PadModel)
        /// The iPod touch device type.
        case pod(PodModel)
        /// The Apple TV device type.
        case tv(TVModel)
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
        /// The iPhone XS.
        case iPhoneXS
        /// The iPhone XS Max.
        case iPhoneXSMax
        /// The iPhone XR.
        case iPhoneXR
        /// The iPhone 11.
        case iPhone11
        /// The iPhone 11 Pro.
        case iPhone11Pro
        /// The iPhone 11 Pro Max.
        case iPhone11ProMax
        /// The second generation of iPhone SE (2020).
        case iPhoneSE2020
        /// The iPhone 12 Mini.
        case iPhone12Mini
        /// The iPhone 12.
        case iPhone12
        /// The iPhone 12 Pro.
        case iPhone12Pro
        /// The iPhone 12 Pro Max.
        case iPhone12ProMax
        /// The iPhone 13 Mini.
        case iPhone13Mini
        /// The iPhone 13.
        case iPhone13
        /// The iPhone 13 Pro.
        case iPhone13Pro
        /// The iPhone 13 Pro Max.
        case iPhone13ProMax
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
        /// The iPad 6.
        case iPad6
        /// The iPad 7.
        case iPad7
        /// The iPad 8.
        case iPad8
        /// The iPad 9.
        case iPad9
        /// The first iPad Air.
        case iPadAir
        /// The iPad Air 2.
        case iPadAir2
        /// The iPad Air 3.
        case iPadAir3
        /// The iPad Air 4.
        case iPadAir4
        /// The first iPad mini.
        case iPadMini
        /// The iPad mini 2.
        case iPadMini2
        /// The iPad mini 3.
        case iPadMini3
        /// The iPad mini 4.
        case iPadMini4
        /// The iPad mini 5.
        case iPadMini5
        /// The iPad mini 6.
        case iPadMini6
        /// The iPad Pro.
        case iPadPro(ScreenSize)
        /// The iPad Pro 2.
        case iPadPro2(ScreenSize)
        /// The iPad Pro 3.
        case iPadPro3(ScreenSize)
        /// The iPad Pro 4.
        case iPadPro4(ScreenSize)
        /// The iPad Pro 5.
        case iPadPro5(ScreenSize)
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
        /// The seventh generation of iPod touch.
        case touch7g
    }
    
    /// The Apple TV device type representation.
    public enum TVModel: Int, Equatable, Comparable {
        /// An unknown Apple TV model.
        case unknown
        /// The fourth generation of Apple TV.
        case tv4g
        /// The Apple TV 4K.
        case tv4k
        /// The Apple TV 4K 2.
        case tv4k2
    }

    #if swift(>=4.2)
    extension PhoneModel: CaseIterable {}
	extension PadModel: CaseIterable {
		public static var allCases: [PadModel] {
			return [
                .unknown,
                .iPad1, .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPad7, .iPad8, .iPad9,
                .iPadAir, .iPadAir2, .iPadAir3, .iPadAir4,
                .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadMini5, .iPadMini6,
                .iPadPro(.inch9p7), .iPadPro(.inch12p9),
                .iPadPro2(.inch10p5), .iPadPro2(.inch12p9),
                .iPadPro3(.inch11), .iPadPro3(.inch12p9),
                .iPadPro4(.inch11), .iPadPro4(.inch12p9),
                .iPadPro5(.inch11), .iPadPro5(.inch12p9)
            ]
		}
	}
    extension PodModel: CaseIterable {}
    extension TVModel: CaseIterable {}
    #endif
    
    public func <(lhs: PhoneModel, rhs: PhoneModel) -> Bool { return lhs.rawValue < rhs.rawValue }
    public func <(lhs: PodModel, rhs: PodModel) -> Bool { return lhs.rawValue < rhs.rawValue }
    public func <(lhs: TVModel, rhs: TVModel) -> Bool { return lhs.rawValue < rhs.rawValue }

    public extension UIDevice {
        /// Returns a string containing the device code.
        var deviceCode: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            
            return String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
        }
        
        /// Returns the device type.
        var device: DeviceType {
            switch deviceCode {
            case "iPhone1,1": return .phone(.iPhone)
            case "iPhone1,2": return .phone(.iPhone3G)
            case "iPhone2,1": return .phone(.iPhone3GS)
            case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .phone(.iPhone4)
            case "iPhone4,1", "iPhone4,2", "iPhone4,3": return .phone(.iPhone4s)
            case "iPhone5,1", "iPhone5,2": return .phone(.iPhone5)
            case "iPhone5,3", "iPhone5,4": return .phone(.iPhone5c)
            case "iPhone6,1", "iPhone6,2": return .phone(.iPhone5s)
            case "iPhone7,2": return .phone(.iPhone6)
            case "iPhone7,1": return .phone(.iPhone6Plus)
            case "iPhone8,1": return .phone(.iPhone6s)
            case "iPhone8,2": return .phone(.iPhone6sPlus)
            case "iPhone8,4": return .phone(.iPhoneSE)
            case "iPhone9,1", "iPhone9,3": return .phone(.iPhone7)
            case "iPhone9,2", "iPhone9,4": return .phone(.iPhone7Plus)
            case "iPhone10,1", "iPhone10,4": return .phone(.iPhone8)
            case "iPhone10,2", "iPhone10,5": return .phone(.iPhone8Plus)
            case "iPhone10,3", "iPhone10,6": return .phone(.iPhoneX)
            case "iPhone11,2": return .phone(.iPhoneXS)
            case "iPhone11,4", "iPhone11,6": return .phone(.iPhoneXSMax)
            case "iPhone11,8": return .phone(.iPhoneXR)
            case "iPhone12,1": return .phone(.iPhone11)
            case "iPhone12,3": return .phone(.iPhone11Pro)
            case "iPhone12,5": return .phone(.iPhone11ProMax)
            case "iPhone12,8": return .phone(.iPhoneSE2020)
            case "iPhone13,1": return .phone(.iPhone12Mini)
            case "iPhone13,2": return .phone(.iPhone12)
            case "iPhone13,3": return .phone(.iPhone12Pro)
            case "iPhone13,4": return .phone(.iPhone12ProMax)
            case "iPhone14,2": return .phone(.iPhone13Pro)
            case "iPhone14,3": return .phone(.iPhone13ProMax)
            case "iPhone14,4": return .phone(.iPhone13Mini)
            case "iPhone14,5": return .phone(.iPhone13)
            
            case "iPad1,1": return .pad(.iPad1)
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .pad(.iPad2)
            case "iPad3,1", "iPad3,2", "iPad3,3": return .pad(.iPad3)
            case "iPad3,4", "iPad3,5", "iPad3,6": return .pad(.iPad4)
            case "iPad4,1", "iPad4,2", "iPad4,3": return .pad(.iPadAir)
            case "iPad5,3", "iPad5,4": return .pad(.iPadAir2)
            case "iPad2,5", "iPad2,6", "iPad2,7": return .pad(.iPadMini)
            case "iPad4,4", "iPad4,5", "iPad4,6": return .pad(.iPadMini2)
            case "iPad4,7", "iPad4,8", "iPad4,9": return .pad(.iPadMini3)
            case "iPad5,1", "iPad5,2": return .pad(.iPadMini4)
            case "iPad6,3", "iPad6,4": return .pad(.iPadPro(.inch9p7))
			case "iPad6,7", "iPad6,8": return .pad(.iPadPro(.inch12p9))
            case "iPad6,11", "iPad6,12": return .pad(.iPad5)
            case "iPad7,1", "iPad7,2": return .pad(.iPadPro2(.inch12p9))
			case "iPad7,3", "iPad7,4": return .pad(.iPadPro2(.inch10p5))
            case "iPad7,5", "iPad7,6": return .pad(.iPad6)
            case "iPad7,11", "iPad7,12": return .pad(.iPad7)
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .pad(.iPadPro3(.inch11))
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .pad(.iPadPro3(.inch12p9))
            case "iPad8,9", "iPad8,10": return .pad(.iPadPro4(.inch11))
            case "iPad8,11", "iPad8,12": return .pad(.iPadPro4(.inch12p9))
            case "iPad11,1", "iPad11,2": return .pad(.iPadMini5)
            case "iPad11,3", "iPad11,4": return .pad(.iPadAir3)
            case "iPad11,6", "iPad11,7": return .pad(.iPad8)
            case "iPad12,1", "iPad12,2": return .pad(.iPad9)
            case "iPad13,1", "iPad13,2": return .pad(.iPadAir4)
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7": return .pad(.iPadPro3(.inch11))
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11": return .pad(.iPadPro5(.inch12p9))
            case "iPad14,1", "iPad14,2": return .pad(.iPadMini6)
            
            case "iPod1,1": return .pod(.touch1g)
            case "iPod2,1": return .pod(.touch2g)
            case "iPod3,1": return .pod(.touch3g)
            case "iPod4,1": return .pod(.touch4g)
            case "iPod5,1": return .pod(.touch5g)
            case "iPod7,1": return .pod(.touch6g)
            case "iPod9,1": return .pod(.touch7g)
            
            case "AppleTV5,3": return .tv(.tv4g)
            case "AppleTV6,2": return .tv(.tv4k)
            case "AppleTV11,1": return .tv(.tv4k2)
            
            case "i386", "x86_64", "arm64": return .simulator
            
            default:
                if deviceCode.contains("iPhone") { return .phone(.unknown) }
                else if deviceCode.contains("iPad") { return .pad(.unknown) }
                else if deviceCode.contains("iPod") { return .pod(.unknown) }
                else if deviceCode.contains("AppleTV") { return .tv(.unknown) }
                else { return .unknown }
            }
        }
        
        /// Returns the amount of free space on the file system in megabytes.
        var freeDiskSpace: Int64 {
            if let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
                return (attributes[.systemFreeSize] as? Int64 ?? 0) / 1024 / 1024
            }
            return 0
        }
        
        /// Returns the size of the file system in megabytes.
        var diskSize: Int64 {
            if let attributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
                return (attributes[.systemSize] as? Int64 ?? 0) / 1024 / 1024
            }
            return 0
        }
    }

#endif
