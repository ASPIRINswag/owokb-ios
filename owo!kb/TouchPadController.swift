//
//  VirtualKeyboardController.swift
//  owo!kb
//
//  Created by Илья Добряков on 10/02/2019.
//  Copyright © 2019 Илья Добряков. All rights reserved.
//

import UIKit

class TouchPadController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        touchPadArea.layer.cornerRadius = 12
    }
    
    var buttonTimer:Timer!
    
    @IBOutlet weak var touchPadArea: UIButton!
    @IBAction func touchPadPosition(_ sender: UIButton, forEvent event: UIEvent) {
        if event.touches(for: sender)?.first?.phase == .began {
            buttonTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in print("x:", event.touches(for: sender)?.first?.location(in: sender).x.description as! String, "    y:", event.touches(for: sender)?.first?.location(in: sender).y.description as! String)})
        }
        
        if event.touches(for: sender)?.first?.phase == .ended{
            buttonTimer.invalidate()
        }
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
