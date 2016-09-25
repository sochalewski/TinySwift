# TinySwift

[![CI Status](http://img.shields.io/travis/sochalewski/TinySwift.svg?style=flat)](https://travis-ci.org/sochalewski/TinySwift)
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

### Array

* `var random`
* `var areAllElementsEqual`
* `func subcript(safe:)`

### AVAsset

* `var thumbnail`

### String

* `init(randomAlphanumericWithLength:)`
* `var trimmed`

### UIImage

* `var jpeg`
* `var normalizedImage`
* `var png`
* `var square`
* `var thumbnail`
* `func applyBorder(width:color:)`
* `func crop(to:)`
* `func jpeg(quality:)`
* `func resize(to:)`

### UIViewController

* `func presentAlertController(withTitle:message:completion:)`

## Author

Piotr Sochalewski, <a href="http://sochalewski.github.io/">sochalewski.github.io</a>

## License

TinySwift is available under the MIT license. See the LICENSE file for more info.
