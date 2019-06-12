//
//  ViewController.swift
//  osu! Keyboard
//
//  Created by Илья Добряков on 06/10/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import Foundation
import UIKit

class MainScreen: UIViewController {
    
    
    @IBOutlet var owouiview: UIView!
    @IBOutlet var RegularButtongsContainer: UIView?
    @IBOutlet var CustomScreen: UIView?
    
    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var ESCButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    @IBOutlet weak var SettingsBarButton: UIBarButtonItem!
    @IBAction func GoToSettingsAction(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "mainSettingsScreenNavigationController")
        nextViewController.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = nextViewController.popoverPresentationController!
        popover.barButtonItem = SettingsBarButton
        present(nextViewController, animated: true, completion:nil)
    }
    
    @objc func reload(){
        viewWillAppear(false)
        UIView.transition(with: view, duration: 0.2, options: .transitionCrossDissolve, animations: {self.viewDidAppear(true)}, completion: nil)
    }
    
    @IBAction func SendESC(_ sender: UIButton, forEvent event: UIEvent) {
        ClickProcessor().BigButtonToServer(sender.currentTitle!, event.touches(for: sender)!.first!.phase as UITouch.Phase)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear called with", animated)
        
        switch UserDefaults.standard.string(forKey: "Layout") {
        case "defaultKeys":
            print("Main screen is defaultKeys")
            RegularButtongsContainer?.isHidden = false; CustomScreen?.isHidden = true
        case "touchPad":
            print("Main screen is touchPad")
            RegularButtongsContainer?.isHidden = true; CustomScreen?.isHidden = false
            default:
            print("Main screen is defaultKeys but it called from default statement")
            RegularButtongsContainer?.isHidden = false; CustomScreen?.isHidden = true
        }
        
        switch self.restorationIdentifier {
        case "mainScreen":
            SettingsButton.layer.cornerRadius = 12
            ESCButton.layer.cornerRadius = 12
            if UserDefaults.standard.bool(forKey: "FirstStart"){
                print("This is the first launch! Hello new user!")
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyboard.instantiateViewController(withIdentifier: "firstStartScreen") as! MainScreen
                present(nextViewController, animated: true, completion:nil)
                UserDefaults.standard.set(false, forKey: "FirstStart")
            }
        case "firstStartScreen":
            FirstStartButton.layer.cornerRadius = 12
        default:
            print("What?")
        }
    }
    
    @IBOutlet weak var FirstStartButton: UIButton!
    @IBAction func FirstStartButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
