# TinySwift

[![CI Status](http://img.shields.io/travis/sochalewski/TinySwift.svg?style=flat)](https://travis-ci.org/sochalewski/TinySwift)
[![codecov](https://codecov.io/gh/sochalewski/TinySwift/branch/master/graph/badge.svg)](https://codecov.io/gh/sochalewski/TinySwift)
[![Version](https://img.shields.io/cocoapods/v/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)
[![License](https://img.shields.io/cocoapods/l/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)
[![Platform](https://img.shields.io/cocoapods/p/TinySwift.svg?style=flat)](http://cocoapods.org/pods/TinySwift)

## Requirements

Swift 3, iOS 8+

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

* `var thumbnail`

### Collection

* `var random`

#### Array

* `var areAllElementsEqual`
* `var average`
* `var sum`
* `subscript(safe:)`

### Date

* `var firstOfMonth`
* `var firstOfYear`
* `var lastOfMonth`
* `var lastOfYear`
* `var weekday`

### Integer

* `var factorial`

### String

* `init(randomAlphanumericWithLength:)`
* `var initials`
* `var lines`
* `var nonEmptyLines`
* `var trimmed`

### UIColor

* `init(hex:alpha:)`

### UIImage

* `var jpeg`
* `var normalizedImage`
* `var png`
* `var square`
* `var thumbnail`
* `func border(width:color:)`
* `func color(atPoint:)`
* `func crop(to:)`
* `func jpeg(quality:)`
* `func resize(to:)`

### UIScreen

* `var isPad13OrBigger`
* `var isSmallScreen`

### UIViewController

* `func presentAlertController(withTitle:message:completion:)`

## Author

Piotr Sochalewski, <a href="http://sochalewski.github.io/">sochalewski.github.io</a>

## License

TinySwift is available under the MIT license. See the LICENSE file for more info.
