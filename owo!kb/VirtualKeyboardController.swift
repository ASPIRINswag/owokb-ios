//
//  VirtualKeyboardController.swift
//  owo!kb
//
//  Created by Илья Добряков on 10/02/2019.
//  Copyright © 2019 Илья Добряков. All rights reserved.
//

import UIKit

class VirtualKeyboardController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var LastChar: UILabel!
    @IBOutlet weak var HackTextField: UITextField!
    @IBAction func HackTextFieldAction(_ sender: Any) {
        switch HackTextField.text {
        case "":
            ClickProcessor().keyPressedToServer("backspace")
            LastChar.text = "Backspace"
        case "\\_":
            ClickProcessor().keyPressedToServer("underscore")
            LastChar.text = "_"
        case "\\ ":
            ClickProcessor().keyPressedToServer("space")
            LastChar.text = "Space"
        default:
            ClickProcessor().keyPressedToServer(String(HackTextField.text!.dropFirst()))
            LastChar.text = String(HackTextField.text!.dropFirst())
        }
        HackTextField.text = "\\"
        HackTextField.undoManager?.removeAllActions()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ClickProcessor().keyPressedToServer("enter")
        LastChar.text = "Enter"
        //HackTextField.resignFirstResponder()
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       if UserDefaults.standard.string(forKey: "Layout") == "virtualKeyboard" {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardDidHideNotification, object: nil)
            HackTextField.delegate = self
            HackTextField.becomeFirstResponder()
            HackTextField.text = "\\"
            LastChar.text = ""
        }
    }
    
    @objc func keyboardWillDisappear() {
        if UserDefaults.standard.string(forKey: "Layout") == "virtualKeyboard" {
            HackTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        HackTextField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
