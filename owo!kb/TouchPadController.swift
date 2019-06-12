//
//  VirtualKeyboardController.swift
//  owo!kb
//
//  Created by Илья Добряков on 10/02/2019.
//  Copyright © 2019 Илья Добряков. All rights reserved.
//

import UIKit

class TouchPadController: UIViewController {

    var buttonTimer:Timer!
    @IBOutlet var touchPadDebugInfo: UILabel!
    @IBOutlet weak var touchPadArea: UIButton!
    @IBAction func touchPadPosition(_ sender: UIButton, forEvent event: UIEvent) {
        if event.touches(for: sender)?.first?.phase == .began {
            if #available(iOS 10.0, *) {
                buttonTimer = Timer.scheduledTimer(withTimeInterval: 0.017, repeats: true, block:{ (Timer) in self.getPos((event.touches(for: sender)?.first)!)})
            } else {
                // Fallback on earlier versions
                //oops
            }
        } //0.017

        if event.touches(for: sender)?.first?.phase == .ended{
            buttonTimer.invalidate()
        }
    }

    func getPos (_ touch: UITouch){
        touchPadDebugInfo.text = "X: \(touch.location(in: self.view).x) Y: \(touch.location(in: self.view).y)"
        print("x:", Double(touch.location(in: self.view).x), "    y:", Double(touch.location(in: self.view).y), "    raw:", touch.location(in: self.view))
        ClickProcessor().touchPadPosotionToServer(touch.location(in: self.view))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touchPadArea.layer.cornerRadius = 12
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillAppear), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
}
