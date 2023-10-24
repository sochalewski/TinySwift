# TinySwift

[![CI Status](https://github.com/sochalewski/TinySwift/actions/workflows/actions.yml/badge.svg)](https://github.com/sochalewski/TinySwift/actions)
[![codecov](https://codecov.io/gh/sochalewski/TinySwift/branch/master/graph/badge.svg)](https://codecov.io/gh/sochalewski/TinySwift)
[![Version](https://img.shields.io/cocoapods/v/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)
[![License](https://img.shields.io/cocoapods/l/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)
[![Platform](https://img.shields.io/cocoapods/p/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)

## Requirements

iOS 12+, tvOS 12+, watchOS 4+

## Installation

TinySwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TinySwift"
```

## Usage

TinySwift is an extension pack for Swift classes and structs.

It contains the following functions and properties:

### AVAsset

* `var thumbnail` <sup>iOS, tvOS</sup>

### Bool

* `init(_: Integer)` <sup>iOS, tvOS, watchOS</sup>
* `static var random` <sup>iOS, tvOS, watchOS</sup>
* `func toggle()` <sup>iOS, tvOS, watchOS</sup>

### CGAffineTransform

* `var rotationAngle` <sup>iOS, tvOS, watchOS</sup>
* `var scaleX` <sup>iOS, tvOS, watchOS</sup>
* `var scaleY` <sup>iOS, tvOS, watchOS</sup>

### Collection

* `var random` <sup>iOS, tvOS, watchOS</sup>

#### Array

* `subscript(safe:)` <sup>iOS, tvOS, watchOS</sup>
* `var shuffled` <sup>iOS, tvOS</sup>
* `func remove(element:)` <sup>iOS, tvOS, watchOS</sup>
* `func shuffle()` <sup>iOS, tvOS</sup>

#### RandomAccessCollection

* `var appearances` <sup>iOS, tvOS, watchOS</sup>
* `var arithmeticMean` <sup>iOS, tvOS, watchOS</sup>
* `var areAllElementsEqual` <sup>iOS, tvOS, watchOS</sup>
* `var geometricMean` <sup>iOS, tvOS, watchOS</sup>
* `var median` <sup>iOS, tvOS, watchOS</sup>
* `var mode` <sup>iOS, tvOS, watchOS</sup>
* `var set` <sup>iOS, tvOS, watchOS</sup>
* `var standardDeviation` <sup>iOS, tvOS, watchOS</sup>
* `var sum` <sup>iOS, tvOS, watchOS</sup>
* `var variance` <sup>iOS, tvOS, watchOS</sup>

### Data

* `init(hexadecimalString:)` <sup>iOS, tvOS, watchOS</sup>
* `var hexadecimalString` <sup>iOS, tvOS, watchOS</sup>
* `func qrCode(correctionLevel:)` <sup>iOS, tvOS</sup>

### Date

* `var day` <sup>iOS, tvOS, watchOS</sup>
* `var firstOfMonth` <sup>iOS, tvOS, watchOS</sup>
* `var firstOfYear` <sup>iOS, tvOS, watchOS</sup>
* `var lastOfMonth` <sup>iOS, tvOS, watchOS</sup>
* `var lastOfYear` <sup>iOS, tvOS, watchOS</sup>
* `var month` <sup>iOS, tvOS, watchOS</sup>
* `var nextDay` <sup>iOS, tvOS, watchOS</sup>
* `var previousDay` <sup>iOS, tvOS, watchOS</sup>
* `var weekday` <sup>iOS, tvOS, watchOS</sup>
* `var year` <sup>iOS, tvOS, watchOS</sup>

### FloatingPoint

* `var additiveInverse` <sup>iOS, tvOS, watchOS</sup>
* `var degreesToRadians` <sup>iOS, tvOS, watchOS</sup>
* `var multiplicativeInverse` <sup>iOS, tvOS, watchOS</sup>
* `var radiansToDegrees` <sup>iOS, tvOS, watchOS</sup>

### Integer

* `var additiveInverse` <sup>iOS, tvOS, watchOS</sup>
* `var days` <sup>iOS, tvOS, watchOS</sup>
* `var degreesToRadians` <sup>iOS, tvOS, watchOS</sup>
* `var factorial` <sup>iOS, tvOS, watchOS</sup>
* `var hours` <sup>iOS, tvOS, watchOS</sup>
* `var isEven` <sup>iOS, tvOS, watchOS</sup>
* `var isOdd` <sup>iOS, tvOS, watchOS</sup>
* `var isPrime` <sup>iOS, tvOS, watchOS</sup>
* `var minutes` <sup>iOS, tvOS, watchOS</sup>
* `var multiplicativeInverse` <sup>iOS, tvOS, watchOS</sup>
* `var radiansToDegrees` <sup>iOS, tvOS, watchOS</sup>
* `var seconds` <sup>iOS, tvOS, watchOS</sup>

#### Int

* `init(random:)` <sup>iOS, tvOS, watchOS</sup>
* `var random` <sup>iOS, tvOS, watchOS</sup>
* `func times(execute:)` <sup>iOS, tvOS, watchOS</sup>

### NSAttributedString

* `func formatted(substring:font:)` <sup>iOS, tvOS, watchOS</sup>

### String

* `init(path:)` <sup>iOS, tvOS, watchOS</sup>
* `init(random:length:nonRepeating:)` <sup>iOS, tvOS, watchOS</sup>
* `var camelCased` <sup>iOS, tvOS, watchOS</sup>
* `var dataFromHexadecimalString` <sup>iOS, tvOS, watchOS</sup>
* `var emptyIfNil` <sup>iOS, tvOS, watchOS</sup>
* `var initials` <sup>iOS, tvOS, watchOS</sup>
* `var isEmailAddress` <sup>iOS, tvOS, watchOS</sup>
* `var lines` <sup>iOS, tvOS, watchOS</sup>
* `var localized` <sup>iOS, tvOS, watchOS</sup>
* `var nilIfEmpty` <sup>iOS, tvOS, watchOS</sup>
* `var nonEmptyLines` <sup>iOS, tvOS, watchOS</sup>
* `var trimmed` <sup>iOS, tvOS, watchOS</sup>
* `var upperCamelCased` <sup>iOS, tvOS, watchOS</sup>
* `func formatted(substring:font:)` <sup>iOS, tvOS, watchOS</sup>
* `func occurrences(of:)` <sup>iOS, tvOS, watchOS</sup>
* `func qrCode(correctionLevel:encoding:)` <sup>iOS, tvOS</sup>

### TimeInterval

* `func time(with:)` <sup>iOS, tvOS, watchOS</sup>

### UIColor

* `init(hex:alpha:)` <sup>iOS, tvOS, watchOS</sup>
* `var hex` <sup>iOS, tvOS, watchOS</sup>

### UIDevice

* `var device` <sup>iOS, tvOS</sup>
* `var deviceCode` <sup>iOS, tvOS</sup>
* `var diskSize` <sup>iOS, tvOS</sup>
* `var freeDiskSpace` <sup>iOS, tvOS</sup>

### UIImage

* `init(color:size:)` <sup>iOS, tvOS, watchOS</sup>
* `var grayscale` <sup>iOS, tvOS</sup>
* `var normalizedImage` <sup>iOS, tvOS, watchOS</sup>
* `var png` <sup>iOS, tvOS, watchOS</sup>
* `var square` <sup>iOS, tvOS, watchOS</sup>
* `var thumbnail` <sup>iOS, tvOS, watchOS</sup>
* `static func get(from:completion:)` <sup>iOS, tvOS, watchOS</sup>
* `func border(width:color:)` <sup>iOS, tvOS, watchOS</sup>
* `func color(at:)` <sup>iOS, tvOS, watchOS</sup>
* `func crop(to:)` <sup>iOS, tvOS, watchOS</sup>
* `func heic(quality:)` <sup>iOS, tvOS</sup>
* `func jpeg(quality:)` <sup>iOS, tvOS, watchOS</sup>
* `func resize(to:)` <sup>iOS, tvOS, watchOS</sup>

### UIImageView

* `func setImage(from:placeholder:completion:)` <sup>iOS, tvOS</sup>
* `func sharpenForQRCode()` <sup>iOS, tvOS</sup>

### UIScreen

* `var isLowResolution` <sup>tvOS</sup>
* `var isSmallScreen` <sup>iOS</sup>
* `var size` <sup>iOS</sup>

### UITableViewCell

* `func hideSeparator()` <sup>iOS</sup>

### UIView

* `var viewFromNib` <sup>iOS, tvOS</sup>

### UIViewController

* `func presentAlertController(withTitle:message:completion:handler:)` <sup>iOS, tvOS</sup>

### URL

* `func qrCode(correctionLevel:encoding:)` <sup>iOS, tvOS</sup>

### WKInterfaceDevice

* `var device` <sup>watchOS</sup>
* `var isSmaller` <sup>watchOS</sup>
* `var isLarger` <sup>watchOS</sup>

## Author

Piotr Sochalewski, <a href="http://sochalewski.github.io/">sochalewski.github.io</a>

## License

TinySwift is available under the MIT license. See the LICENSE file for more info.
