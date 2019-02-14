//
//  ViewController.swift
//  osu! Keyboard
//
//  Created by Илья Добряков on 06/10/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import Foundation
import UIKit
import Socket

class MainScreen: UIViewController {
    
    @IBOutlet var RegularButtongsContainer: UIView?
    @IBOutlet var VirtualFullsizeKB: UIView?
    @IBOutlet var CustomScreen: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.restorationIdentifier == "mainScreen" {
            if UserDefaults.standard.string(forKey: "Layout") == "defaultKeys" {
                print("Main screen is RegularButtongsContainer")
                self.RegularButtongsContainer?.isHidden = false; self.VirtualFullsizeKB?.isHidden = true; self.CustomScreen?.isHidden = true
            } else if UserDefaults.standard.string(forKey: "Layout") == "virtualKeyboard" {
                print("Main screen is VirtualFullsizeKB")
                self.RegularButtongsContainer?.isHidden = true; self.VirtualFullsizeKB?.isHidden = false; self.CustomScreen?.isHidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
