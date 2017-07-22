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

#if os(iOS) || os(tvOS)
/// SoundCategory is a convenient wrapper for AVAudioSessions category constants.
    public enum SoundCategory {

        /// Equivalent of AVAudioSessionCategoryAmbient.
        case ambient
        /// Equivalent of AVAudioSessionCategorySoloAmbient.
        case soloAmbient
        /// Equivalent of AVAudioSessionCategoryPlayback.
        case playback
        /// Equivalent of AVAudioSessionCategoryRecord.
        case record
        /// Equivalent of AVAudioSessionCategoryPlayAndRecord.
        case playAndRecord

        fileprivate var avFoundationCategory: String {
            get {
                switch self {
                case .ambient:
                    return AVAudioSessionCategoryAmbient
                case .soloAmbient:
                    return AVAudioSessionCategorySoloAmbient
                case .playback:
                    return AVAudioSessionCategoryPlayback
                case .record:
                    return AVAudioSessionCategoryRecord
                case .playAndRecord:
                    return AVAudioSessionCategoryPlayAndRecord
                }
            }
        }
    }
#endif

/// Sound is a class that allows you to easily play sounds in Swift. It uses AVFoundation framework under the hood.
open class Sound {

    // MARK: - Global settings

    /// Number of AVAudioPlayer instances created for every sound. SwiftySound creates 5 players for every sound to make sure that it will be able to play the same sound more than once. If your app doesn't need this functionality, you can reduce the number of players to 1 and reduce memory usage. You can increase the number if your app plays the sound more than 5 times at the same time.
    public static var playersPerSound: Int = 5 {
        didSet {
            stopAll()
            sounds.removeAll()
        }
    }

    #if os(iOS) || os(tvOS)
    /// Sound session. The default value is the shared `AVAudioSession` session.
    public static var session: Session = AVAudioSession.sharedInstance()

    /// Sound category for current session. Using this variable is a convenient way to set AVAudioSessions category. The default value is .ambient.
    public static var category: SoundCategory = {
        let defaultCategory = SoundCategory.ambient
        try? session.setCategory(defaultCategory.avFoundationCategory)
        return defaultCategory
        }() {
        didSet {
            try? session.setCategory(category.avFoundationCategory)
        }
    }
    #endif

    private static var sounds = [URL: Sound]()

    private static let defaultsKey = "com.moonlightapps.SwiftySound.enabled"

    /// Globally enable or disable sound. This setting value is stored in UserDefaults and will be loaded on app launch.
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

    private let players: [Player]

    private var counter = 0

    /// The class that is used to create `Player` instances. Defaults to `AVAudioPlayer`.
    public static var playerClass: Player.Type = AVAudioPlayer.self

    // MARK: - Initialization

    /// Create a sound object.
    ///
    /// - Parameter url: Sound file URL.
    public init?(url: URL) {
        #if os(iOS) || os(tvOS)
            _ = Sound.category
        #endif
        let playersPerSound = max(Sound.playersPerSound, 1)
        var myPlayers: [Player] = []
        myPlayers.reserveCapacity(playersPerSound)
        for _ in 0..<playersPerSound {
            if let player = try? Sound.playerClass.init(contentsOf: url) {
                myPlayers.append(player)
            }
        }
        if myPlayers.count == 0 {
            return nil
        }
        players = myPlayers
    }

    // MARK: - Main play method

    /// Play the sound.
    ///
    /// - Parameter numberOfLoops: Number of loops. Specify a negative number for an infinite loop. Default value of 0 means that the sound will be played once.
    /// - Returns: If the sound was played successfully the return value will be true. It will be false if sounds are disabled or if system could not play the sound.
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

    /// Stop playing the sound.
    public func stop() {
        for player in players {
            player.stop()
        }
    }

    // MARK: - Convenience static methods

    /// Play sound from a sound file.
    ///
    /// - Parameters:
    ///   - file: Sound file name.
    ///   - fileExtension: Sound file extension.
    ///   - numberOfLoops: Number of loops. Specify a negative number for an infinite loop. Default value of 0 means that the sound will be played once.
    /// - Returns: If the sound was played successfully the return value will be true. It will be false if sounds are disabled or if system could not play the sound.
    @discardableResult public static func play(file: String, fileExtension: String? = nil, numberOfLoops: Int = 0) -> Bool {
        if let url = url(for: file, fileExtension: fileExtension) {
            return play(url: url, numberOfLoops: numberOfLoops)
        }
        return false
    }

    /// Play a sound from URL.
    ///
    /// - Parameters:
    ///   - url: Sound file URL.
    ///   - numberOfLoops: Number of loops. Specify a negative number for an infinite loop. Default value of 0 means that the sound will be played once.
    /// - Returns: If the sound was played successfully the return value will be true. It will be false if sounds are disabled or if system could not play the sound.
    @discardableResult public static func play(url: URL, numberOfLoops: Int = 0) -> Bool {
        if !Sound.enabled {
            return false
        }
        var sound = sounds[url]
        if sound == nil {
            sound = Sound(url: url)
            sounds[url] = sound
        }
        return sound?.play(numberOfLoops: numberOfLoops) ?? false
    }

    /// Stop playing sound for given URL.
    ///
    /// - Parameter url: Sound file URL.
    public static func stop(for url: URL) {
        let sound = sounds[url]
        sound?.stop()
    }

    /// Duration of the sound.
    public var duration: TimeInterval {
        get {
            return self.players[counter].duration
        }
    }

    /// Sound volume.
    /// A value in the range 0.0 to 1.0, with 0.0 representing the minimum volume and 1.0 representing the maximum volume.
    public var volume: Float {
        get {
            return players[counter].volume
        }
        set {
            for player in players {
                player.volume = newValue
            }
        }
    }
    
    /// Stop playing sound for given sound file.
    ///
    /// - Parameters:
    ///   - file: Sound file name.
    ///   - fileExtension: Sound file extension.
    public static func stop(file: String, fileExtension: String? = nil) {
        if let url = url(for: file, fileExtension: fileExtension) {
            let sound = sounds[url]
            sound?.stop()
        }
    }

    /// Stop playing all sounds.
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

/// Player protocol. It duplicates `AVAudioPlayer` methods.
public protocol Player: class {

    /// Play the sound.
    ///
    /// - Returns: true if the sound was played successfully. False otherwise.
    func play() -> Bool

    /// Stop playing the sound.
    func stop()

    /// Create a Player for sound url.
    ///
    /// - Parameter url: sound url.
    init(contentsOf url: URL) throws

    /// Number of loops.
    var numberOfLoops: Int { get set }

    /// Duration of the sound.
    var duration: TimeInterval { get }
    
    /// Sound volume.
    var volume: Float { get set }
}

extension AVAudioPlayer: Player {}

#if os(iOS) || os(tvOS)
/// Session protocol. It duplicates `setCategory` method of `AVAudioSession` class.
public protocol Session: class {
    /// Set category for session.
    ///
    /// - Parameter category: category.
    func setCategory(_ category: String) throws
}

extension AVAudioSession: Session {}
#endif
