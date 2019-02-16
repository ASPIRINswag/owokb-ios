//
//  File.swift
//  osu! Keyboard
//
//  Created by Илья Добряков on 06/10/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import Foundation
import UIKit
import Socket
import AudioToolbox

public class ClickProcessor {
    
    //keyboard:key,N_up
    //keyboard:key,N_down
    
    let delegate = UIApplication.shared.delegate as! AppDelegate

    public func keyDownToServer(_ keyName: String) {
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "PressedBigButtons") + 1, forKey: "PressedBigButtons")
        do {
            if UserDefaults.standard.integer(forKey: "NetProtocol") == 0 {
                print("UDP Key", keyName, "down to", UserDefaults.standard.string(forKey: "ServerIp")! + ":" + String(UserDefaults.standard.integer(forKey: "ServerPort")))
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "sentUDP") + 1, forKey: "sentUDP")
                try delegate.socketUDP.write(from: ("keyboard:key," + keyName + "_down").data(using: .utf8)!, to: Socket.createAddress(for: UserDefaults.standard.string(forKey: "ServerIp") ?? "192.168.0.1", on: Int32(UserDefaults.standard.integer(forKey: "ServerPort")))!)
            } else if UserDefaults.standard.integer(forKey: "NetProtocol") == 1 {
                print("TCP Key", keyName, "down to", UserDefaults.standard.string(forKey: "ServerIp")! + ":" + String(UserDefaults.standard.integer(forKey: "ServerPort")))
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "sentTCP") + 1, forKey: "sentTCP")
                delegate.socketTCP = try Socket.create(connectedUsing: Socket.Signature(protocolFamily: .inet, socketType: .stream, proto: .tcp, hostname: UserDefaults.standard.string(forKey: "ServerIp"), port: Int32(UserDefaults.standard.string(forKey: "ServerPort")!))!)
                try delegate.socketTCP.write(from: ("keyboard:key," + keyName + "_down").data(using: .utf8)!)
            }
        } catch let error {
            guard let socketError = error as? Socket.Error else {
                print("Unexpected error...")
                return
            }
            print("Error reported: \(socketError.description)")
        }
        if UserDefaults.standard.bool(forKey: "Taptic") == true {
            
            //6s
            AudioServicesPlaySystemSound(1520)
            
            //7 and newer
            UIImpactFeedbackGenerator(style: .medium).prepare()
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }

    public func keyUpToServer(_ keyName: String){
        do {
            if UserDefaults.standard.integer(forKey: "NetProtocol") == 0 {
                print("UDP Key", keyName, "up")
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "sentUDP") + 1, forKey: "sentUDP")
                try delegate.socketUDP.write(from: ("keyboard:key," + keyName + "_up").data(using: .utf8)!, to: Socket.createAddress(for: UserDefaults.standard.string(forKey: "ServerIp") ?? "192.168.0.1", on: Int32(UserDefaults.standard.integer(forKey: "ServerPort")))!)
            }else if UserDefaults.standard.integer(forKey: "NetProtocol") == 1 {
                print("TCP Key", keyName, "up")
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "sentTCP") + 1, forKey: "sentTCP")
                delegate.socketTCP = try Socket.create(connectedUsing: Socket.Signature(protocolFamily: .inet, socketType: .stream, proto: .tcp, hostname: UserDefaults.standard.string(forKey: "ServerIp"), port: Int32(UserDefaults.standard.string(forKey: "ServerPort")!))!)
                try delegate.socketTCP.write(from: ("keyboard:key," + keyName + "_up").data(using: .utf8)!)
            }
        } catch let error {
            guard let socketError = error as? Socket.Error else {
                print("Unexpected error...")
                return
            }
            print("Error reported: \(socketError.description)")
        }
        if UserDefaults.standard.bool(forKey: "Taptic") == true {
            
            //6s
            AudioServicesPlaySystemSound(1520)
            
            //7 and newer
            UIImpactFeedbackGenerator(style: .medium).prepare()
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
    
}

	
