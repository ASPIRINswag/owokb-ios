//
//  StatisticsController.swift
//  owo!kb
//
//  Created by Илья Добряков on 16/02/2019.
//  Copyright © 2019 Илья Добряков. All rights reserved.
//

import UIKit

class StatisticsController: UITableViewController {
    
    @IBOutlet var Table: UITableView!
    
    @IBOutlet weak var BigButtonsNum: UILabel!
    @IBOutlet weak var iOSkbNum: UILabel!
    @IBOutlet weak var sentUDPnum: UILabel!
    @IBOutlet weak var sentTCPnum: UILabel!
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                let alert = UIAlertController(title: "Do you want to reset statistics?", message: "Warning! This action will erase all your statistics without any able to bring it back!", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    print("deliting statistics")
                    UserDefaults.standard.set(0, forKey: "PressedBigButtons")
                    UserDefaults.standard.set(0, forKey: "sentUDP")
                    UIView.transition(with: self.Table, duration: 0.8, options: .transitionFlipFromRight, animations: {self.viewDidLoad()}, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                
                if let popoverPresentationController = alert.popoverPresentationController {
                    popoverPresentationController.sourceView = self.tableView.cellForRow(at: indexPath)
                    popoverPresentationController.sourceRect = tableView.cellForRow(at: indexPath)!.bounds
                }
                self.present(alert, animated: true, completion: nil)
            }
            if indexPath.row == 1 {
                let alert = UIAlertController(title: "Do you want to reset everyting?", message: "Warning! This action will erase all your statistics and all settings without any able to bring it back!", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    print("deliting statistics")
                    
                    UserDefaults.standard.set(true, forKey: "FirstStart")
                    UserDefaults.standard.set("192.168.0.1", forKey: "ServerIp")
                    UserDefaults.standard.set("727", forKey: "ServerPort")
                    UserDefaults.standard.set("0", forKey: "NetProtocol")
                    UserDefaults.standard.set("defaultKeys", forKey: "Layout")
                    UserDefaults.standard.set(2, forKey: "ButtonsCount")
                    
                    UserDefaults.standard.set(false, forKey: "Taptic")
                    
                    UserDefaults.standard.set("Z", forKey: "ButtonKey1")
                    UserDefaults.standard.set("X", forKey: "ButtonKey2")
                    UserDefaults.standard.set("D", forKey: "ButtonKey3")
                    UserDefaults.standard.set("F", forKey: "ButtonKey4")
                    UserDefaults.standard.set("G", forKey: "ButtonKey5")
                    UserDefaults.standard.set("H", forKey: "ButtonKey6")
                    UserDefaults.standard.set("J", forKey: "ButtonKey7")
                    UserDefaults.standard.set("K", forKey: "ButtonKey8")
                    UserDefaults.standard.set("L", forKey: "ButtonKey9")
                    
                    UserDefaults.standard.set(0, forKey: "PressedBigButtons")
                    UserDefaults.standard.set(0, forKey: "sentUDP")
                    exit(0);
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                
                if let popoverPresentationController = alert.popoverPresentationController {
                    popoverPresentationController.sourceView = self.tableView.cellForRow(at: indexPath)
                    popoverPresentationController.sourceRect = tableView.cellForRow(at: indexPath)!.bounds
                }
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BigButtonsNum.text = String(UserDefaults.standard.integer(forKey: "PressedBigButtons"))
        sentUDPnum.text = String(UserDefaults.standard.integer(forKey: "sentUDP"))
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
