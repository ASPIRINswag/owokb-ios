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
                let alert = UIAlertController(title: "Do you want to reset?", message: "Warning! This action will erase all your statistics without any able to bring it back!", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    print("deliting statistics")
                    UserDefaults.standard.set(0, forKey: "PressedBigButtons")
                    UserDefaults.standard.set(0, forKey: "iOSKb")
                    UserDefaults.standard.set(0, forKey: "sentUDP")
                    UserDefaults.standard.set(0, forKey: "sentTCP")
                    UIView.transition(with: self.Table, duration: 0.8, options: .transitionFlipFromRight, animations: {self.viewDidLoad()}, completion: nil)
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
        iOSkbNum.text = String(UserDefaults.standard.integer(forKey: "iOSKb"))
        sentUDPnum.text = String(UserDefaults.standard.integer(forKey: "sentUDP"))
        sentTCPnum.text = String(UserDefaults.standard.integer(forKey: "sentTCP"))
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
