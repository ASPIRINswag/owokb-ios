//
//  File.swift
//  owo!kb
//
//  Created by Илья Добряков on 11/11/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import Foundation
import UIKit
import SwiftSocket

class SettingsScreen: UITableViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    
    static func CreateConnection() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.client.close()
        print("Creating new connection. Connection closed")
        delegate.client = UDPClient(address: UserDefaults.standard.string(forKey: "ServerIp")!, port: Int32(UserDefaults.standard.integer(forKey: "ServerPort")))
        print("New connection is ", UserDefaults.standard.string(forKey: "ServerIp")!, ":", UserDefaults.standard.integer(forKey: "ServerPort"))
    }

    @IBOutlet weak var IPAddressField: UITextField!
    @IBAction func IpWasChanged(_ sender: Any) {
        defaults.set(IPAddressField.text, forKey: "ServerIp")
        SettingsScreen.CreateConnection()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        _ = delegate.client.send(data: ("IPAdressOfDevice_" + "127.0.0.1, this is just weird placeholder lmao").data(using: .utf8)!)
    }
    
    @IBOutlet weak var PortAddressField: UITextField!
    @IBAction func PortWasChanged(_ sender: Any) {
        defaults.set(PortAddressField.text, forKey: "ServerPort")
        SettingsScreen.CreateConnection()
    }
    
    @IBOutlet weak var FourKeySwitch: UISwitch!
    @IBOutlet weak var UnitedKeySwitch: UISwitch!
    
    @IBAction func FourKeySwitchAction(_ sender: Any) {
        if FourKeySwitch.isOn {
            UnitedKeySwitch.setOn(false, animated:true)
            defaults.set(UnitedKeySwitch.isOn, forKey: "UnitedKeySwitch")
            defaults.set(FourKeySwitch.isOn, forKey: "FourKeySwitch")
            print("4k screen enabled")
        }
        if !FourKeySwitch.isOn {
            defaults.set(FourKeySwitch.isOn, forKey: "FourKeySwitch")
            print("2k screen enabled")
        }
    }
    
    @IBAction func UnitedKeyAction(_ sender: Any) {
        if UnitedKeySwitch.isOn {
            FourKeySwitch.setOn(false, animated:true)
            defaults.set(FourKeySwitch.isOn, forKey: "FourKeySwitch")
            defaults.set(UnitedKeySwitch.isOn, forKey: "UnitedKeySwitch")
            print("1k screen enabled")
        }
        if !UnitedKeySwitch.isOn {
            defaults.set(UnitedKeySwitch.isOn, forKey: "UnitedKeySwitch")
            print("2k screen enabled")
        }
    }
    
    //DELETE THIS
    @IBOutlet weak var Kluge1K: UITextField!
    @IBAction func ChangeUIView2K_1K(_ sender: Any) {
        defaults.set(Kluge1K.text, forKey: "UIView2K_1K")
        print("First key was remapped to", Kluge1K.text!)
    }
    
    @IBOutlet weak var Kluge2K: UITextField!
    @IBAction func ChangeUIView2K_2K(_ sender: Any) {
        defaults.set(Kluge2K.text, forKey: "UIView2K_2K")
        print("Second key was remapped to", Kluge2K.text!)
    }
    //NO REALLY
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                guard let url = URL(string: "https://github.com/kitty433cute/osukb_rbld/releases") else { return }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
        
    @IBOutlet weak var AppVersion: UILabel!
    @IBOutlet weak var AppBuild: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.restorationIdentifier == "mainSettingsScreen" {
            
            self.IPAddressField.delegate = self
            
            IPAddressField.text = defaults.string(forKey: "ServerIp")
            
            self.AppVersion.text = "Version: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")  as! String)"
            self.AppBuild.text = "Build: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String)"
            print("Version and Build number was loaded")
        }
        
        if self.restorationIdentifier == "experimentalSettingsScreen" {
            
            self.PortAddressField.delegate = self
            self.Kluge1K.delegate = self
            self.Kluge2K.delegate = self
            
            PortAddressField.text = defaults.string(forKey: "ServerPort")
            Kluge1K.text = defaults.string(forKey: "UIView2K_1K")
            Kluge2K.text = defaults.string(forKey: "UIView2K_2K")
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        if self.restorationIdentifier == "mainSettingsScreen" {
            FourKeySwitch.isOn = defaults.bool(forKey: "FourKeySwitch")
            UnitedKeySwitch.isOn = defaults.bool(forKey: "UnitedKeySwitch")
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
