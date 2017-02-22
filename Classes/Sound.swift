//
//  Sound.swift
//  SwiftySound
//
//  Created by Adam Cichy on 21/02/17.
//
//  Copyright (c) 2017 Adam Cichy
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import AVFoundation

open class Sound {

    public static var playersPerSound: Int = 5 {
        didSet {
            Sound.stopAll()
            Sound.sounds.removeAll()
        }
    }

    private static var sounds = [URL: Sound]()

    private static let defaultsKey = "com.moonlightapps.SwiftySound.enabled"

    public static var enabled: Bool = {
        return !UserDefaults.standard.bool(forKey: defaultsKey)
        }() { didSet {
            let value = !enabled
            UserDefaults.standard.set(value, forKey: defaultsKey)
            if value {
                stopAll()
            }
        }
    }

    private let players: [AVAudioPlayer]

    private var counter = 0

    // MARK: - Initialization
    public init?(url: URL) {
        var myPlayers: [AVAudioPlayer] = []
        for _ in 0..<Sound.playersPerSound {
            if let player = try? AVAudioPlayer(contentsOf: url) {
                myPlayers.append(player)
            }
        }
        if myPlayers.count == 0 {
            return nil
        }
        players = myPlayers
        Sound.sounds[url] = self
    }

    // MARK: - Main play method
    @discardableResult public func play(numberOfLoops: Int = 0) -> Bool {
        if !Sound.enabled {
            return false
        }
        let player = players[counter]
        counter = (counter + 1) % players.count
        player.numberOfLoops = numberOfLoops
        return player.play()
    }

    // MARK: - Stop playing
    public func stop() {
        for player in players {
            player.stop()
        }
    }

    // MARK: - Convenience static methods
    @discardableResult public static func play(file: String, fileExtension: String? = nil, numberOfLoops: Int = 0) -> Bool {
        if let url = url(for: file, fileExtension: fileExtension) {
            return play(url: url, numberOfLoops: numberOfLoops)
        }
        return false
    }

    @discardableResult public static func play(url: URL, numberOfLoops: Int = 0) -> Bool {
        if !Sound.enabled {
            return false
        }
        var sound = sounds[url]
        if sound == nil {
            sound = Sound(url: url)
        }
        return sound?.play(numberOfLoops: numberOfLoops) ?? false
    }

    public static func stop(for url: URL) {
        let sound = sounds[url]
        sound?.stop()
    }

    public static func stop(file: String, fileExtension: String? = nil) {
        if let url = url(for: file, fileExtension: fileExtension) {
            let sound = sounds[url]
            sound?.stop()
        }
    }

    public static func stopAll() {
        for sound in sounds.values {
            sound.stop()
        }
    }

    // MARK: - Private helper method
    private static func url(for file: String, fileExtension: String? = nil) -> URL? {
        return Bundle.main.url(forResource: file, withExtension: fileExtension)
    }

}
