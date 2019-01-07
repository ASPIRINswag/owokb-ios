//
//  File.swift
//  osu! Keyboard
//
//  Created by Илья Добряков on 06/10/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import Foundation
import UIKit
import SwiftSocket

public class ClickProcessor {
    
    //keyboard:key,N_up
    //keyboard:key,N_down
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    public func keyDownToServer(_ keyName: String){
        print("Key ", keyName, " down to ", UserDefaults.standard.string(forKey: "ServerIp")!, ":", UserDefaults.standard.integer(forKey: "ServerPort"))
        _ = delegate.client.send(data: ("keyboard:key," + keyName + "_down").data(using: .utf8)!)
    }
    
    public func keyUpToServer(_ keyName: String){
        print("Key ", keyName, " up")
        _ = delegate.client.send(data: ("keyboard:key," + keyName + "_up").data(using: .utf8)!)
    }
}

	
