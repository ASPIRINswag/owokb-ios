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
    
    public func BigButtonToServer(_ keyName: String, _ keyPhase: UITouch.Phase) {
        DispatchQueue.global(qos: .userInitiated).async {
            if UserDefaults.standard.integer(forKey: "NetProtocol") == 0 {
                if keyPhase == .began {
                    self.sentUDPpackage(keyName + "_down")
                } else if keyPhase == .ended {
                    self.sentUDPpackage(keyName + "_up")
                }
            } else if UserDefaults.standard.integer(forKey: "NetProtocol") == 1 {
                if keyPhase == .began {
                    self.sentTCPpackage(keyName + "_down")
                } else if keyPhase == .ended {
                    self.sentTCPpackage(keyName + "_up")
                }
            }
            DispatchQueue.main.async {
                if UserDefaults.standard.bool(forKey: "Taptic") == true {
                    self.inputFeedback()
                }
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "PressedBigButtons") + 1, forKey: "PressedBigButtons")
            }
        }
    }
    
    public func keyPressedToServer(_ keyName: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            if UserDefaults.standard.integer(forKey: "NetProtocol") == 0 {
                self.sentUDPpackage(keyName + "_pressed")
            } else if UserDefaults.standard.integer(forKey: "NetProtocol") == 1 {
                self.sentTCPpackage(keyName + "_pressed")
            }
            DispatchQueue.main.async {
                UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "iOSKb") + 1, forKey: "iOSKb")
            }
        }
    }
    
    
    internal func sentUDPpackage(_ package: String) {
        do{
            try delegate.socketUDP.write(from: (package).data(using: .utf8)!, to: Socket.createAddress(for: UserDefaults.standard.string(forKey: "ServerIp") ?? "192.168.0.1", on: Int32(UserDefaults.standard.integer(forKey: "ServerPort")))!)
        } catch let error {
            guard let socketError = error as? Socket.Error else {
                print("Unexpected error...")
                return
            }
            print("Error reported: \(socketError.description)")
        }
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "sentUDP") + 1, forKey: "sentUDP")
        print("UDP:", package)
    }
    
    internal func sentTCPpackage(_ package: String){
        do{
            delegate.socketTCP = try Socket.create(connectedUsing: Socket.Signature(protocolFamily: .inet, socketType: .stream, proto: .tcp, hostname: UserDefaults.standard.string(forKey: "ServerIp"), port: Int32(UserDefaults.standard.string(forKey: "ServerPort")!))!)
            try delegate.socketTCP.write(from: (package).data(using: .utf8)!)
        } catch let error {
            guard let socketError = error as? Socket.Error else {
                print("Unexpected error...")
                return
            }
            print("Error reported: \(socketError.description)")
        }
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "sentTCP") + 1, forKey: "sentTCP")
        print("TCP:", package)
    }
    
    internal func inputFeedback(){
        //6s
        AudioServicesPlaySystemSound(1520)
        
        //7 and newer
        UIImpactFeedbackGenerator(style: .medium).prepare()
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
}

	
