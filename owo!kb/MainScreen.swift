//
//  ViewController.swift
//  osu! Keyboard
//
//  Created by Илья Добряков on 06/10/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import Foundation
import UIKit
import SwiftSocket

class MainScreen: UIViewController {
    let defaults = UserDefaults.standard
    let ServerSend = ClickProcessor()
    
    @IBOutlet var UIView2k: UIView?
    @IBOutlet var UIView4k: UIView?
    @IBOutlet var UIView1k: UIView!
    
    //UIView2K buttons
    @IBOutlet weak var UIView2K_1K: UIButton!
    @IBOutlet weak var UIView2K_2K: UIButton!
    
    //funcs for regular buttons
    @IBAction func keyDown(_ sender: UIButton) {
        ServerSend.keyDownToServer(sender.currentTitle!)
    }
    
    @IBAction func keyUp(_ sender: UIButton) {
        ServerSend.keyUpToServer(sender.currentTitle!)
//        print(UIControl.Event.Type.self)
//        if (UIControl.Event.self = .TouchUpInside) {
//            print("TouchUpInside")
//        }
//        if (UIControl.Event.self = .TouchUpOutside) {
//            print("TouchUpOutside")
//        }
    }
    
    //funcs for one single big button
    @IBAction func kDown(_ sender: Any) {
        ServerSend.keyDownToServer("X")
    }
    
    @IBAction func kUp(_ sender: Any) {
        ServerSend.keyUpToServer("X")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func ScreenChange(){
        if (defaults.bool(forKey: "FourKeySwitch") == false) && (defaults.bool(forKey: "UnitedKeySwitch") == false){
            print("Switches are off, loading 2k screen")
            self.UIView2k?.isHidden = false; self.UIView4k?.isHidden = true; self.UIView1k?.isHidden = true
        }
        else if (defaults.bool(forKey: "FourKeySwitch") == true){
            print("FourKeySwitch is on, loading 4k screen")
            self.UIView2k?.isHidden = true; self.UIView4k?.isHidden = false; self.UIView1k?.isHidden = true
        }
        else if (defaults.bool(forKey: "UnitedKeySwitch") == true){
            print("UnitedKeySwitch is on, loading 1k screen")
            self.UIView2k?.isHidden = true; self.UIView4k?.isHidden = true; self.UIView1k?.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.restorationIdentifier == "mainScreen" { ScreenChange()}
        
        //buttons renaming
        if self.restorationIdentifier == "2k_screen" {
            print("Renaming 2k buttons")
            UIView2K_1K.setTitle(defaults.string(forKey: "UIView2K_1K"), for: .normal)
            UIView2K_2K.setTitle(defaults.string(forKey: "UIView2K_2K"), for: .normal)
        } else if self.restorationIdentifier == "4k_screen" {
            print("Renaming 4k buttons is not implemented")
        } else if self.restorationIdentifier == "united_Screen" {
            print("Renaming UnitedKey button is not implemented")
        }
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
