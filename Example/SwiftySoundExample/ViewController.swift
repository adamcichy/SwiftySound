//
//  ViewController.swift
//  SwiftySoundExample
//
//  Created by Adam Cichy on 21/02/17.
//  Copyright © 2017 Adam CIchy. All rights reserved.
//

import UIKit
import SwiftySound

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var switchSoundEnabled: UISwitch!
    @IBOutlet weak var textFieldNumberOfLoops: UITextField!
    @IBOutlet weak var buttonDog: UIButton!
    @IBOutlet weak var buttonCat: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    @IBOutlet weak var labelVolume: UILabel!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var buttonDogWithVolume: UIButton!

    private var dogSound: Sound?

    override func viewDidLoad() {
        super.viewDidLoad()
        switchSoundEnabled.isOn = Sound.enabled
        if let dogUrl = Bundle.main.url(forResource: "dog", withExtension: "wav") {
            dogSound = Sound(url: dogUrl)
        }
    }

    private func numberOfLoops() -> Int {
        if let str = textFieldNumberOfLoops.text, let result = Int(str) {
            return result
        }
        return 0
    }

    // MARK: - Actions
    @IBAction func buttonDogClicked(_ sender: Any) {
        Sound.play(file: "dog", fileExtension: "wav", numberOfLoops: numberOfLoops())
    }

    @IBAction func buttonCatClicked(_ sender: Any) {
        Sound.play(file: "cat", fileExtension: "wav", numberOfLoops: numberOfLoops())
    }

    @IBAction func buttonDogWithVolumeClicked(_ sender: Any) {
        dogSound?.play { completed in
            print("completed: \(completed)")
        }
    }

    @IBAction func buttonStopClicked(_ sender: Any) {
        Sound.stopAll()
    }

    @IBAction func switchSoundEnabledValueChanged(_ sender: UISwitch) {
        Sound.enabled = sender.isOn
    }

    @IBAction func sliderVolumeValueChanged(_ sender: UISlider) {
        dogSound?.volume = sender.value
        labelVolume.text = "volume: \(String(format: "%0.0f", (sender.value * 100)))%"
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }

}
