//
//  File.swift
//  owo!kb
//
//  Created by Илья Добряков on 11/11/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import Foundation
import UIKit
import Socket

class SettingsLayout: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var LayoutButtonsNum: UITextField!
    @IBAction func LayoutButtonsNumAction(_ sender: Any) {
        if Int(LayoutButtonsNum.text!)! > 9 {
            LayoutButtonsNum.text = "9"
        } else if Int(LayoutButtonsNum.text!)! < 1 {
            LayoutButtonsNum.text = "1"
        }
        UserDefaults.standard.set(LayoutButtonsNum.text, forKey: "ButtonsCount")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.restorationIdentifier == "layoutListingScreen" {
            if indexPath.section == 1 {
                if let cell = tableView.cellForRow(at: indexPath) {
                    for i in 0...tableView.numberOfRows(inSection: 1) {
                        tableView.cellForRow(at: [1,i])?.accessoryType = .none
                    }
                    cell.accessoryType = .checkmark
                    UserDefaults.standard.set(cell.restorationIdentifier!, forKey: "Layout")
                    print("layout changed to:", cell.restorationIdentifier!)
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
    
    override func viewDidLoad() {
        if self.restorationIdentifier == "layoutSettingsScreen" {
            LayoutButtonsNum.text = UserDefaults.standard.string(forKey: "ButtonsCount")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //some stuff
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
}
