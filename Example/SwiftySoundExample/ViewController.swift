//
//  ViewController.swift
//  SwiftySoundExample
//
//  Created by Adam Cichy on 21/02/17.
//  Copyright © 2017 Adam CIchy. All rights reserved.
//

import SwiftySound
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var switchSoundEnabled: UISwitch!
    @IBOutlet var switchBackgroundMusic: UISwitch!
    @IBOutlet var textFieldNumberOfLoops: UITextField!
    @IBOutlet var buttonDog: UIButton!
    @IBOutlet var buttonCat: UIButton!
    @IBOutlet var buttonStop: UIButton!
    @IBOutlet var labelVolume: UILabel!
    @IBOutlet var sliderVolume: UISlider!
    @IBOutlet var buttonDogWithVolume: UIButton!

    private var backgroundSound: Sound?
    private var dogSound: Sound?

    override func viewDidLoad() {
        super.viewDidLoad()
        switchSoundEnabled.isOn = Sound.enabled
        if let dogUrl = Bundle.main.url(forResource: "dog", withExtension: "wav") {
            dogSound = Sound(url: dogUrl)
        }
        if let pianoUrl = Bundle.main.url(forResource: "piano", withExtension: "wav") {
            backgroundSound = Sound(url: pianoUrl)
            backgroundSound?.volume = 0.8
            backgroundSound?.prepare()
        }
    }

    private func numberOfLoops() -> Int {
        if let str = textFieldNumberOfLoops.text, let result = Int(str) {
            return result
        }
        return 0
    }

    // MARK: - Actions

    @IBAction func buttonDogClicked(_: Any) {
        Sound.play(file: "dog", fileExtension: "wav", numberOfLoops: numberOfLoops())
    }

    @IBAction func buttonCatClicked(_: Any) {
        Sound.play(file: "cat", fileExtension: "wav", numberOfLoops: numberOfLoops())
    }

    @IBAction func buttonDogWithVolumeClicked(_: Any) {
        dogSound?.play { completed in
            print("completed: \(completed)")
        }
    }

    @IBAction func buttonStopClicked(_: Any) {
        Sound.stopAll()
        switchBackgroundMusic.isOn = false
    }

    @IBAction func switchSoundEnabledValueChanged(_ sender: UISwitch) {
        Sound.enabled = sender.isOn
        if switchBackgroundMusic.isOn {
            enableBackgroundMusic()
        }
    }

    @IBAction func switchBackgroundMusicValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            enableBackgroundMusic()
        } else {
            disableBackgroundMusic()
        }
    }

    @IBAction func sliderVolumeValueChanged(_ sender: UISlider) {
        dogSound?.volume = sender.value
        labelVolume.text = "volume: \(String(format: "%0.0f", sender.value * 100))%"
    }

    // MARK: - Background music

    private func enableBackgroundMusic() {
        guard let backgroundSound = backgroundSound else { return }
        if !backgroundSound.resume() { // trying to resume
            backgroundSound.play(numberOfLoops: -1) // couldn't resume. most likely because it hasn't been played yet. playing the background sound from start. negative number of loops will cause the sound to loop infinitely
        }
    }

    private func disableBackgroundMusic() {
        backgroundSound?.pause()
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }
}
