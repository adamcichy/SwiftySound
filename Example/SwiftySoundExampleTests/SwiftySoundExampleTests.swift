//
//  SwiftySoundExampleTests.swift
//  SwiftySoundExampleTests
//
//  Created by Adam Cichy on 31/03/2017.
//  Copyright © 2017 Adam CIchy. All rights reserved.
//

import XCTest
import SwiftySound

extension String: Error {}

final class MockPlayer: Player {
    var numberOfLoops: Int = 0

    required init(contentsOf url: URL) throws {
        let fm = FileManager.default
        let attributes = try fm.attributesOfItem(atPath: url.path)
        let size = attributes[FileAttributeKey.size]
        if let fileSize = size as? Int64, fileSize == 0 {
            throw "Empty file"
        }
    }

    func stop() {
    }

    func play() -> Bool {
        return true
    }
}

class SwiftySoundExampleTests: XCTestCase {

    var catSound: Sound?

    override func setUp() {
        super.setUp()
        Sound.playerClass = MockPlayer.self
        Sound.enabled = true
        if let url = Bundle.main.url(forResource: "cat", withExtension: "wav") {
            catSound = Sound(url: url)
        }
    }

    // MARK: Properties

    func testDefaultSoundCategory() {
        let defaultCategory = Sound.category
        XCTAssertEqual(defaultCategory, .ambient)
    }

    func testCategoryChange() {
        Sound.category = SoundCategory.playAndRecord
        XCTAssertEqual(Sound.category, .playAndRecord)
        Sound.category = SoundCategory.record
        XCTAssertEqual(Sound.category, .record)
        Sound.category = SoundCategory.playback
        XCTAssertEqual(Sound.category, .playback)
        Sound.category = SoundCategory.soloAmbient
        XCTAssertEqual(Sound.category, .soloAmbient)
        Sound.category = SoundCategory.ambient
        XCTAssertEqual(Sound.category, .ambient)
    }

    func testEnabled() {
        Sound.enabled = false
        XCTAssertFalse(Sound.enabled)
        Sound.enabled = true
        XCTAssertTrue(Sound.enabled)
    }

    func testPlayersPerSound() {
        Sound.playersPerSound = 10
        XCTAssertEqual(Sound.playersPerSound, 10)
        Sound.playersPerSound = 5
        XCTAssertEqual(Sound.playersPerSound, 5)
    }

    // MARK: Playback
    func testCreatingInstance() {
        if let url = Bundle.main.url(forResource: "dog", withExtension: "wav") {
            let sound = Sound(url: url)
            XCTAssertNotNil(sound)
        }
    }

    func testCreatingInstanceNonExistentFile() {
        if let url = Bundle.main.url(forResource: "nonexistent", withExtension: "wav") {
            let sound = Sound(url: url)
            XCTAssertNil(sound)
        }
    }

    func testCreatingInstanceEmptyFile() {
        if let url = Bundle.main.url(forResource: "empty", withExtension: "wav") {
            let sound = Sound(url: url)
            XCTAssertNil(sound)
        }
    }

    func testNonExisting() {
        let result = Sound.play(file: "nonexistent.mp3")
        XCTAssertFalse(result)
    }

    func testDog() {
        let result = Sound.play(file: "dog.wav")
        XCTAssert(result)
    }

    func testCat() {
        let result = Sound.play(file: "cat.wav")
        XCTAssert(result)
    }

    func testEmpty() {
        let result = Sound.play(file: "empty.wav")
        XCTAssertFalse(result)
    }

    func testStop() {
        if let url = Bundle.main.url(forResource: "dog", withExtension: "wav"), let sound = Sound(url: url) {
            sound.play()
            sound.stop()
            Sound.play(file: "dog.wav")
            Sound.stop(file: "dog.wav")
            Sound.play(url: url, numberOfLoops: -1)
            Sound.stop(for: url)
            Sound.stopAll()
            XCTAssert(true)
        }
    }

    func testNotEnabledPlayback() {
        Sound.enabled = false
        if let url = Bundle.main.url(forResource: "dog", withExtension: "wav"), let sound = Sound(url: url) {
            let result = sound.play()
            XCTAssertFalse(result)
            let resultForStaticMethod = Sound.play(file: "dog.wav")
            XCTAssertFalse(resultForStaticMethod)
            Sound.enabled = true
            let resultWhenSoundEnabled = sound.play()
            XCTAssert(resultWhenSoundEnabled)
            let resultForStaticMethodWhenSoundEnabled = Sound.play(file: "dog.wav")
            XCTAssert(resultForStaticMethodWhenSoundEnabled)
        }
        Sound.enabled = true
    }

}
