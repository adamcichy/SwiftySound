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

    override func viewDidLoad() {
        super.viewDidLoad()
        switchSoundEnabled.isOn = Sound.enabled
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

    @IBAction func buttonStopClicked(_ sender: Any) {
        Sound.stopAll()
    }

    @IBAction func switchSoundEnabledValueChanged(_ sender: UISwitch) {
        Sound.enabled = sender.isOn
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }

}
