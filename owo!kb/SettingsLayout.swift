//
//  File.swift
//  owo!kb
//
//  Created by Илья Добряков on 11/11/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import Foundation
import UIKit

class SettingsLayout: UITableViewController, UITextFieldDelegate {
    
    var dismissHandler: (() -> Void)!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.restorationIdentifier == "layoutListingScreen" {
            if indexPath.section == 1 {
                if let cell = tableView.cellForRow(at: indexPath) {
                    for i in 0...tableView.numberOfRows(inSection: 1) {
                        tableView.cellForRow(at: [1,i])?.accessoryType = .none
                    }
                    cell.accessoryType = .checkmark
                    UserDefaults.standard.set(cell.restorationIdentifier!, forKey: "Layout")
                    print("layout changed to:", cell.restorationIdentifier!)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.restorationIdentifier == "layoutListingScreen" {
            if indexPath.section == 1 {
                if cell.restorationIdentifier! as String == UserDefaults.standard.string(forKey: "Layout") {
                    print(cell.restorationIdentifier!)
                    cell.accessoryType = .checkmark
                }
            }
        }
    }

    @IBOutlet weak var LayoutButtonsNum: UITextField!
    @IBAction func LayoutButtonsNumAction(_ sender: Any) {
        let digits: String = LayoutButtonsNum.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if digits.isEmpty {
            LayoutButtonsNum.text = ""
            return
        } else if Int(digits)! > 9 {
            LayoutButtonsNum.text = "9"
        } else if Int(digits)! < 1 {
            LayoutButtonsNum.text = "1"
        }
        UserDefaults.standard.set(LayoutButtonsNum.text, forKey: "ButtonsCount")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @IBOutlet weak var ButtonKey1: UITextField!
    @IBAction func ButtonKey1Action(_ sender: Any) {
        if ButtonKey1.text != "" {
            UserDefaults.standard.set(String(ButtonKey1.text!.first!).uppercased(), forKey: "ButtonKey1")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    @IBOutlet weak var ButtonKey2: UITextField!
    @IBAction func ButtonKey2Action(_ sender: Any) {
        if ButtonKey2.text != "" {
            UserDefaults.standard.set(String(ButtonKey2.text!.first!).uppercased(), forKey: "ButtonKey2")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    @IBOutlet weak var ButtonKey3: UITextField!
    @IBAction func ButtonKey3Action(_ sender: Any) {
        if ButtonKey3.text != "" {
            UserDefaults.standard.set(String(ButtonKey3.text!.first!).uppercased(), forKey: "ButtonKey3")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    @IBOutlet weak var ButtonKey4: UITextField!
    @IBAction func ButtonKey4Action(_ sender: Any) {
        if ButtonKey4.text != "" {
            UserDefaults.standard.set(String(ButtonKey4.text!.first!).uppercased(), forKey: "ButtonKey4")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    @IBOutlet weak var ButtonKey5: UITextField!
    @IBAction func ButtonKey5Action(_ sender: Any) {
        if ButtonKey5.text != "" {
            UserDefaults.standard.set(String(ButtonKey5.text!.first!).uppercased(), forKey: "ButtonKey5")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    @IBOutlet weak var ButtonKey6: UITextField!
    @IBAction func ButtonKey6Action(_ sender: Any) {
        if ButtonKey6.text != "" {
            UserDefaults.standard.set(String(ButtonKey6.text!.first!).uppercased(), forKey: "ButtonKey6")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    @IBOutlet weak var ButtonKey7: UITextField!
    @IBAction func ButtonKey7Action(_ sender: Any) {
        if ButtonKey7.text != "" {
            UserDefaults.standard.set(String(ButtonKey7.text!.first!).uppercased(), forKey: "ButtonKey7")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    @IBOutlet weak var ButtonKey8: UITextField!
    @IBAction func ButtonKey8Action(_ sender: Any) {
        if ButtonKey8.text != "" {
            UserDefaults.standard.set(String(ButtonKey8.text!.first!).uppercased(), forKey: "ButtonKey8")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    @IBOutlet weak var ButtonKey9: UITextField!
    @IBAction func ButtonKey9Action(_ sender: Any) {
        if ButtonKey9.text != "" {
            UserDefaults.standard.set(String(ButtonKey9.text!.first!).uppercased(), forKey: "ButtonKey9")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.restorationIdentifier == "layoutSettingsScreen" {
            LayoutButtonsNum.text = UserDefaults.standard.string(forKey: "ButtonsCount")
            ButtonKey1.text = UserDefaults.standard.string(forKey: "ButtonKey1")
            ButtonKey2.text = UserDefaults.standard.string(forKey: "ButtonKey2")
            ButtonKey3.text = UserDefaults.standard.string(forKey: "ButtonKey3")
            ButtonKey4.text = UserDefaults.standard.string(forKey: "ButtonKey4")
            ButtonKey5.text = UserDefaults.standard.string(forKey: "ButtonKey5")
            ButtonKey6.text = UserDefaults.standard.string(forKey: "ButtonKey6")
            ButtonKey7.text = UserDefaults.standard.string(forKey: "ButtonKey7")
            ButtonKey8.text = UserDefaults.standard.string(forKey: "ButtonKey8")
            ButtonKey9.text = UserDefaults.standard.string(forKey: "ButtonKey9")
            
            LayoutButtonsNum.delegate = self
            ButtonKey1.delegate = self
            ButtonKey2.delegate = self
            ButtonKey3.delegate = self
            ButtonKey4.delegate = self
            ButtonKey5.delegate = self
            ButtonKey6.delegate = self
            ButtonKey7.delegate = self
            ButtonKey8.delegate = self
            ButtonKey9.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}
