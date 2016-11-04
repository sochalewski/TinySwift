# TinySwift

[![CI Status](http://img.shields.io/travis/sochalewski/TinySwift.svg?style=flat)](https://travis-ci.org/sochalewski/TinySwift)
[![codecov](https://codecov.io/gh/sochalewski/TinySwift/branch/master/graph/badge.svg)](https://codecov.io/gh/sochalewski/TinySwift)
[![Version](https://img.shields.io/cocoapods/v/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)
[![License](https://img.shields.io/cocoapods/l/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)
[![Platform](https://img.shields.io/cocoapods/p/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)

## Requirements

Swift 3

iOS 8+, tvOS 9+, watchOS 2+

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

### Collection

* `var appearances` <sup>iOS, tvOS, watchOS</sup>
* `var arithmeticMean` <sup>iOS, tvOS, watchOS</sup>
* `var geometricMean` <sup>iOS, tvOS, watchOS</sup>
* `var median` <sup>iOS, tvOS, watchOS</sup>
* `var mode` <sup>iOS, tvOS, watchOS</sup>
* `var random` <sup>iOS, tvOS, watchOS</sup>
* `var standardDeviation` <sup>iOS, tvOS, watchOS</sup>
* `var sum` <sup>iOS, tvOS, watchOS</sup>
* `var variance` <sup>iOS, tvOS, watchOS</sup>

#### Array

* `var areAllElementsEqual` <sup>iOS, tvOS, watchOS</sup>
* `var shuffled` <sup>iOS, tvOS</sup>
* `func shuffle()` <sup>iOS, tvOS</sup>
* `subscript(safe:)` <sup>iOS, tvOS, watchOS</sup>

### Date

* `var firstOfMonth` <sup>iOS, tvOS, watchOS</sup>
* `var firstOfYear` <sup>iOS, tvOS, watchOS</sup>
* `var lastOfMonth` <sup>iOS, tvOS, watchOS</sup>
* `var lastOfYear` <sup>iOS, tvOS, watchOS</sup>
* `var tomorrow` <sup>iOS, tvOS, watchOS</sup>
* `var weekday` <sup>iOS, tvOS, watchOS</sup>
* `var yesterday` <sup>iOS, tvOS, watchOS</sup>

### FloatingPoint

* `var additiveInverse` <sup>iOS, tvOS, watchOS</sup>
* `var multiplicativeInverse` <sup>iOS, tvOS, watchOS</sup>

### Integer

* `var additiveInverse` <sup>iOS, tvOS, watchOS</sup>
* `var factorial` <sup>iOS, tvOS, watchOS</sup>
* `var isEven` <sup>iOS, tvOS, watchOS</sup>
* `var isOdd` <sup>iOS, tvOS, watchOS</sup>
* `var isPrimeNumber` <sup>iOS, tvOS, watchOS</sup>
* `var multiplicativeInverse` <sup>iOS, tvOS, watchOS</sup>

#### Int

* `init(random:)` <sup>iOS, tvOS, watchOS</sup>
* `func times(execute:)` <sup>iOS, tvOS, watchOS</sup>

### RawRepresentable: Hashable

* `var all` <sup>iOS, tvOS, watchOS</sup>

### String

* `init(path:)` <sup>iOS, tvOS, watchOS</sup>
* `init(random:length:nonRepeating:)` <sup>iOS, tvOS, watchOS</sup>
* `var initials` <sup>iOS, tvOS, watchOS</sup>
* `var lines` <sup>iOS, tvOS, watchOS</sup>
* `var nonEmptyLines` <sup>iOS, tvOS, watchOS</sup>
* `var trimmed` <sup>iOS, tvOS, watchOS</sup>
* `func occurrences(of:)` <sup>iOS, tvOS, watchOS</sup>

### TimeInterval

* `func time(withFormat:)` <sup>iOS, tvOS, watchOS</sup>

### UIColor

* `init(hex:alpha:)` <sup>iOS, tvOS, watchOS</sup>
* `var hex` <sup>iOS, tvOS, watchOS</sup>

### UIDevice

* `var device` <sup>iOS, tvOS</sup>
* `var deviceCode` <sup>iOS, tvOS</sup>

### UIImage

* `var grayscale` <sup>iOS, tvOS</sup>
* `var jpeg` <sup>iOS, tvOS, watchOS</sup>
* `var normalizedImage` <sup>iOS, tvOS, watchOS</sup>
* `var png` <sup>iOS, tvOS, watchOS</sup>
* `var square` <sup>iOS, tvOS, watchOS</sup>
* `var thumbnail` <sup>iOS, tvOS, watchOS</sup>
* `func border(width:color:)` <sup>iOS, tvOS, watchOS</sup>
* `func color(atPoint:)` <sup>iOS, tvOS, watchOS</sup>
* `func crop(to:)` <sup>iOS, tvOS, watchOS</sup>
* `func jpeg(quality:)` <sup>iOS, tvOS, watchOS</sup>
* `func resize(to:)` <sup>iOS, tvOS, watchOS</sup>

### UIScreen

* `var isSmallScreen` <sup>iOS</sup>
* `var size` <sup>iOS</sup>

### UITableViewCell

* `func hideSeparator()` <sup>iOS</sup>

### UIView

* `var viewFromNib` <sup>iOS, tvOS</sup>

### UIViewController

* `func presentAlertController(withTitle:message:completion:handler:)` <sup>iOS, tvOS</sup>

### WKInterfaceDevice

* `var device` <sup>iOS, watchOS</sup>
* `var is38mm` <sup>iOS, watchOS</sup>
* `var is42mm` <sup>iOS, watchOS</sup>

## Author

Piotr Sochalewski, <a href="http://sochalewski.github.io/">sochalewski.github.io</a>

## License

TinySwift is available under the MIT license. See the LICENSE file for more info.
