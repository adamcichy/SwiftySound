## SwiftySound

[![CocoaPods License](https://img.shields.io/cocoapods/l/SwiftySound.svg)](https://raw.githubusercontent.com/adamcichy/SwiftySound/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftySound.svg)](https://cocoapods.org/pods/SwiftySound)
[![CocoaPods Platforms](https://img.shields.io/cocoapods/p/SwiftySound.svg)](https://cocoapods.org/pods/SwiftySound)
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

Specify a negative number of loops to play the sound continously in an infinite loop:

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

##### Creating instances of *Sound* class

You can also create an instance of a Sound class and store it somewhere in your app.

```swift
let mySound = Sound(url: fileURL)
mySound.play()
```

Creating an instance has more benefits like the ability to adjust the volume and playback callbacks.

##### Change the volume

You can change the volume of each *Sound* instance.

```swift
mySound.volume = 0.5
```
The value of *volume* property should be between 0.0 and 1.0, where 1.0 is the maximum.

##### Callbacks

You can pass a callback to the `play` method. It will be played after the sound finished playing. For looped sounds, the callback will be called once after the last loop has been played.

```swift
mySound.play { completed in
    print("completed: \(completed)")
}
```

<aside class="warning">
The callback is not called if the sound was stopped, interrupted or in case of a playback error.
</aside>

## Features
- [x] Playing single sounds
- [x] Loops
- [x] Infinite loops
- [x] Playing the same sound multiple times simultaneously
- [x] Stopping all sounds with a global static method
- [x] Ability to pause and resume
- [x] Adjusting sound volume
- [x] Callbacks
- [x] Global static variable to enable/disable all sounds

## Requirements
- Swift 5
- Xcode 10.2 or later
- iOS 8.0 or later
- tvOS 9.0 or later
- macOS 10.9 or later

For Xcode 8 and Swift 3 support, please use SwiftySound version `0.7.0`.
For Xcode 9 and Swift 4 support, please use SwiftySound version `1.0.0`.

## Installation
### Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager which automates and simplifies the process of using third-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

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
