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
    
    static func CreateConnection() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.socketUDP.close()
        delegate.socketTCP.close()
        print("Creating new connection. Connection closed")
        
        do {
            if UserDefaults.standard.integer(forKey: "ConnectionType") == 0 {
                delegate.socketUDP = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            } else if UserDefaults.standard.integer(forKey: "ConnectionType") == 1 {
                delegate.socketTCP = try Socket.create(connectedUsing: Socket.Signature(protocolFamily: .inet, socketType: .stream, proto: .tcp, hostname: UserDefaults.standard.string(forKey: "ServerIp"), port: Int32(UserDefaults.standard.integer(forKey: "ServerPort")))!)
            }
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
        let delegate = UIApplication.shared.delegate as! AppDelegate
        do {
            try delegate.socketTCP.write(from: ("owo, you are: " + UserDefaults.standard.string(forKey: "ServerIp")! + ":" + String(UserDefaults.standard.integer(forKey: "ServerPort"))).data(using: .utf8)!)
        } catch let error {
            guard let socketError = error as? Socket.Error else {
                print("Unexpected error...")
                return
            }
            print("Error reported: \(socketError.description)")
        }
    }
    
    @IBOutlet weak var PortAddressField: UITextField!
    @IBAction func PortWasChanged(_ sender: Any) {
        UserDefaults.standard.set(PortAddressField.text, forKey: "ServerPort")
        SettingsScreen.CreateConnection()
    }
    
    @IBOutlet weak var NetProtocol: UISegmentedControl!
    @IBAction func ChangeProtocol(_ sender: Any) {
        UserDefaults.standard.set(NetProtocol.selectedSegmentIndex, forKey: "NetProtocol")
    }
    
    @IBOutlet weak var TapticSwitch: UISwitch!
    @IBAction func TapticSwitchAction(_ sender: Any) {
        UserDefaults.standard.set(TapticSwitch.isOn, forKey: "Taptic")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                guard let url = URL(string: "https://github.com/kitty433cute/osukb_rbld/releases") else { return }
                UIApplication.shared.open(url)
            }
        }
        if self.restorationIdentifier == "layoutSettingsScreen" {
            if let cell = tableView.cellForRow(at: indexPath) {
                for i in 0...tableView.numberOfRows(inSection: 0) {
                    tableView.cellForRow(at: [0,i])?.accessoryType = .none
                }
                cell.accessoryType = .checkmark
                UserDefaults.standard.set(cell.restorationIdentifier!, forKey: "Layout")
                print("layout changed to:", cell.restorationIdentifier!)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.restorationIdentifier == "layoutSettingsScreen" {
            if cell.restorationIdentifier! as String == UserDefaults.standard.string(forKey: "Layout"){
                cell.accessoryType = .checkmark
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 2 {
            if self.restorationIdentifier == "mainSettingsScreen" {
                return "Version: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")  as! String) \nBuild: \(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String) \n\nWork with network by BlueSocket\nCopyright © 2016 IBM. All rights reserved."
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.restorationIdentifier == "mainSettingsScreen" {
            IPAddressField.text = UserDefaults.standard.string(forKey: "ServerIp")
            TapticSwitch.isOn = UserDefaults.standard.bool(forKey: "Taptic")
        } else if self.restorationIdentifier == "experimentalSettingsScreen" {
            PortAddressField.text = UserDefaults.standard.string(forKey: "ServerPort")
            NetProtocol.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "NetProtocol")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.restorationIdentifier == "mainSettingsScreen" {
            super.viewWillDisappear(animated)
            if self.isMovingFromParent {
                VirtualKeyboardController().view.setNeedsLayout()
                VirtualKeyboardController().view.layoutIfNeeded()
            }
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
