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
    
    func ScreenChange(){
        if UserDefaults.standard.integer(forKey: "ButtonsCount") <= 9{
            print("Main screen is RegularButtongsContainer")
            self.RegularButtongsContainer?.isHidden = false; self.VirtualFullsizeKB?.isHidden = true; self.CustomScreen?.isHidden = true
        } else if UserDefaults.standard.integer(forKey: "ButtonsCount") == 10{
            print("Main screen is VirtualFullsizeKB")
            self.RegularButtongsContainer?.isHidden = true; self.VirtualFullsizeKB?.isHidden = false; self.CustomScreen?.isHidden = true
            
        }
//        } else if UserDefaults.standard.integer(forKey: "ButtonsCount") <= 11{
//            print("Main screen is CustomScreen")
//            self.RegularButtongsContainer?.isHidden = true; self.VirtualFullsizeKB?.isHidden = true; self.CustomScreen?.isHidden = false
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.restorationIdentifier == "mainScreen" { ScreenChange()}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
