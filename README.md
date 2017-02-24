##Swifty Sound

[![CocoaPods](https://img.shields.io/cocoapods/l/SwiftySound.svg)](https://raw.githubusercontent.com/adamcichy/SwiftySound/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftySound.svg)](http://cocoadocs.org/docsets/SwiftySound/)
[![CocoaPods](https://img.shields.io/cocoapods/p/SwiftySound.svg)](http://cocoadocs.org/docsets/SwiftySound/)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/SwiftySound.svg)](http://cocoadocs.org/docsets/SwiftySound/)

## Overview
Swifty Sound is a simple library that lets you deal with Swift sounds easily.
#####Static methods

```swift
Sound.play(file: "dog.wav")
```

```swift
Sound.play(url: fileURL)
```

More advanced example:

```swift
Sound.play(file: "dog", fileExtension: "wav", numberOfLoops: 3)
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

#####Creating instances of `Sound` class
You can also create an instance of a Sound class and store it somewhere in your app.
```swift
let sound = Sound(url: fileURL)
sound.play()
```

## Features
- [x] Playing single sounds
- [x] Loops
- [x] Infinite loops
- [x] Global static variable to enable/disable all sounds

## Requirements
- iOS 8.0 or later
- tvOS 9.0 or later
- OS X 10.10 or later
- Xcode 8.0 or later

## Installation
### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```
platform :ios, '8.0'
use_frameworks!
pod 'SwiftySound'
```

### Manually
Drop the `Sound.swift` file into your project, link against `AVFoundation.framework` and you are ready to go.

## Licenses

Swifty Sound is licensed under the [MIT License](https://raw.githubusercontent.com/adamcichy/SwiftySound/master/LICENSE).
