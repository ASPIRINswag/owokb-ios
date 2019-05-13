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
    
    @IBOutlet var owouiview: UIView!
    @IBOutlet var RegularButtongsContainer: UIView?
    @IBOutlet var VirtualFullsizeKB: UIView?
    @IBOutlet var CustomScreen: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    @IBOutlet weak var GoToSettings: UIButton!
//    @IBAction func GoToSettingsAction(_ sender: Any) {
//        switch UIDevice.current.userInterfaceIdiom {
//        case .phone:
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mainSettingsScreen") as! SettingsScreen
//            self.navigationController?.pushViewController(nextViewController, animated: true)
//        case .pad:
//            if self.SettingsScreenContainer.isHidden == true {
//                self.SettingsConstraint.constant = self.view.frame.width * 0.7
//                self.ButtonsConstraint.constant = self.view.frame.width * 0.3
//                self.SettingsScreenContainer.isHidden = false
//                GoToSettings.setTitle("Close settings", for: .normal)
//                UIView.animate(withDuration: 0.3) {
//                    self.view.layoutIfNeeded()
//                }
//            } else if self.SettingsScreenContainer.isHidden == false {
//                self.SettingsConstraint.constant = self.view.frame.width
//                self.ButtonsConstraint.constant = self.view.frame.width
//                self.SettingsScreenContainer.isHidden = true
//                GoToSettings.setTitle("Settings", for: .normal)
//                UIView.animate(withDuration: 0.3) {
//                    self.view.layoutIfNeeded()
//                }
//            }
//        default:
//            print("what")
//        }
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.restorationIdentifier == "mainScreen" {
            //addChild(UIViewController)
//            self.addChildViewController(RegularButtongsContainer)
//            self.view.addSubview(vc.view)
//            vc.didMoveToParentViewController(self)
            
            if UserDefaults.standard.string(forKey: "Layout") == "defaultKeys" {
                print("Main screen is RegularButtongsContainer")
                self.RegularButtongsContainer?.isHidden = false; self.VirtualFullsizeKB?.isHidden = true; self.CustomScreen?.isHidden = true
            } else if UserDefaults.standard.string(forKey: "Layout") == "virtualKeyboard" {
                print("Main screen is VirtualFullsizeKB")
                self.RegularButtongsContainer?.isHidden = true; self.VirtualFullsizeKB?.isHidden = false; self.CustomScreen?.isHidden = true
            } else if UserDefaults.standard.string(forKey: "Layout") == "touchPad" {
                print("Main screen is VirtualFullsizeKB")
                self.RegularButtongsContainer?.isHidden = true; self.VirtualFullsizeKB?.isHidden = true; self.CustomScreen?.isHidden = false
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
