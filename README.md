## SwiftySound

[![CocoaPods License](https://img.shields.io/cocoapods/l/SwiftySound.svg)](https://raw.githubusercontent.com/adamcichy/SwiftySound/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftySound.svg)](https://cocoapods.org/pods/SwiftySound)
[![CocoaDocs](https://img.shields.io/cocoapods/p/SwiftySound.svg)](http://cocoadocs.org/docsets/SwiftySound/)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/SwiftySound.svg)](http://cocoadocs.org/docsets/SwiftySound/)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![SPM ready](https://img.shields.io/badge/SPM-ready-orange.svg)](https://swift.org/package-manager/)
[![Build status](https://api.travis-ci.org/adamcichy/SwiftySound.svg?branch=master)](https://travis-ci.org/adamcichy/SwiftySound)
[![codecov](https://codecov.io/gh/adamcichy/SwiftySound/branch/master/graph/badge.svg)](https://codecov.io/gh/adamcichy/SwiftySound)
[![codebeat](https://codebeat.co/badges/b51bedad-3c13-4ef2-a632-5c4e3d4fa759)](https://codebeat.co/projects/github-com-adamcichy-swiftysound-master)
[![Codacy](https://api.codacy.com/project/badge/Grade/048aad599e8549fa9f5d433f690dd796)](https://www.codacy.com/app/adamcichy/SwiftySound?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=adamcichy/SwiftySound&amp;utm_campaign=Badge_Grade)

## Overview
SwiftySound is a simple library that lets you deal with Swift sounds easily.

##### Static methods

```swift
Sound.play(file: "dog.wav")
```

```swift
Sound.play(url: fileURL)
```

More advanced example:

```swift
Sound.play(file: "dog", fileExtension: "wav", numberOfLoops: 2)
```
The above will play the sound three times.

Specify a negative number of loops to play the sound continously in an intinite loop:

```swift
Sound.play(file: "dog", fileExtension: "wav", numberOfLoops: -1)
```

Stop currently playing sounds:

```swift
Sound.stopAll()
```

Enable/disable all sounds:

```swift
Sound.enabled = true
Sound.enabled = false
```

The value of `Sound.enabled` property will be automatically persisted in `UserDefaults` and restored on the next launch of your app.

Change sound categories. SwiftySound provides a simple way of changing sound category:

```swift
Sound.category = .ambient
```
This changes the category of the underlying shared `AVAudioSession` instance. The default value is `SoundCategory.ambient`. Due to `AVAudioSession` architecture, this property is not available on macOS.

##### Creating instances of `Sound` class

You can also create an instance of a Sound class and store it somewhere in your app.
```swift
let sound = Sound(url: fileURL)
sound.play()
```

## Features
- [x] Playing single sounds
- [x] Loops
- [x] Infinite loops
- [x] Playing the same sound multiple times simultaneously
- [x] Global static variable to enable/disable all sounds

## Requirements
- Swift 3
- Xcode 8.0 or later
- iOS 8.0 or later
- tvOS 9.0 or later
- macOS 10.9 or later

## Installation
### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```ruby
platform :ios, '8.0'
use_frameworks!
pod 'SwiftySound'
```
### Installation with Carthage
[Carthage](https://github.com/Carthage/Carthage) is a lightweight dependency manager for Swift and Objective-C. It leverages CocoaTouch modules and is less invasive than CocoaPods.

To install with carthage, follow the instruction on [Carthage](https://github.com/Carthage/Carthage)

#### Cartfile
```
github "adamcichy/SwiftySound"
```

### Installation with Swift Package Manager

The Swift Package Manager is a tool for managing the distribution of Swift code. Just add the url of this repo to your `Package.swift` file as a dependency:

```swift
import PackageDescription

let package = Package(
    name: "YourPackage",
    dependencies: [
        .Package(url: "https://github.com/adamcichy/SwiftySound.git",
                 majorVersion: 0)
    ]
)
```

Then run `swift build` and wait for SPM to install SwiftySound.

### Manual installation
Drop the `Sound.swift` file into your project, link against `AVFoundation.framework` and you are ready to go.

## Licenses

SwiftySound is licensed under the [MIT License](https://raw.githubusercontent.com/adamcichy/SwiftySound/master/LICENSE).
