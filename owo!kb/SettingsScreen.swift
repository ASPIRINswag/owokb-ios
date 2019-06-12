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

class SettingsScreen: UITableViewController, UITextFieldDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.restorationIdentifier == "mainSettingsScreen" {
            IPAddressField.text = UserDefaults.standard.string(forKey: "ServerIp")
            TapticSwitch.isOn = UserDefaults.standard.bool(forKey: "Taptic")
            PortAddressField.text = UserDefaults.standard.string(forKey: "ServerPort")
            CloseSettingsButton.layer.cornerRadius = 12
        }
        IPAddressField.delegate = self
        PortAddressField.delegate = self
    }
    
    @IBOutlet weak var CloseSettingsButton: UIButton!
    @IBAction func CloseSettingsAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    static func CreateConnection() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.socketUDP.close()
        print("Creating new connection. Connection closed")

        do {
            delegate.socketUDP = try Socket.create(family: .inet, type: .datagram, proto: .udp)
        } catch let error {
            guard let socketError = error as? Socket.Error else {
                print("Unexpected error...")
                return
            }
            print("Error reported: \(socketError.description)")
        }
        print("New connection is: " + UserDefaults.standard.string(forKey: "ServerIp")! + ":" + String(UserDefaults.standard.integer(forKey: "ServerPort")))
    }

    @IBOutlet weak var IPAddressField: UITextField!
    @IBAction func IpWasChanged(_ sender: Any) {
        UserDefaults.standard.set(IPAddressField.text, forKey: "ServerIp")
        SettingsScreen.CreateConnection()
    }

    @IBOutlet weak var PortAddressField: UITextField!
    @IBAction func PortWasChanged(_ sender: Any) {
        UserDefaults.standard.set(PortAddressField.text, forKey: "ServerPort")
        SettingsScreen.CreateConnection()
    }

    @IBOutlet weak var TapticSwitch: UISwitch!
    @IBAction func TapticSwitchAction(_ sender: Any) {
        UserDefaults.standard.set(TapticSwitch.isOn, forKey: "Taptic")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.restorationIdentifier == "mainSettingsScreen" {
            tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.section == 2 {
                if indexPath.row == 0 {
                    guard let url = URL(string: "https://github.com/ASPIRINswag/owokb-ios") else { return }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 2 {
            if self.restorationIdentifier == "mainSettingsScreen" {
                return "Version: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")  as! String) \nBuild: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String) \n\nWork with network by BlueSocket under the terms of Apache license 2.0\n\nCopyright © 2016 IBM. All rights reserved."
            } else {
                return ""
            }
        } else {
            return ""
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
