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

//        let tap = UILongPressGestureRecognizer(target: self, action: #selector(tapHandler))
//        tap.minimumPressDuration = 0
//        view.addGestureRecognizer(tap)
    }
    
//    @IBOutlet weak var touchPadArea: UIButton!
//    @IBAction func touchPadPosition(_ sender: UIButton, forEvent event: UIEvent) {
//        if event.touches(for: sender)?.first?.phase == .began {
//            buttonTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (Timer) in self.getPos(event.touches(for: sender)!.first!.location(in: sender), event, sender)}) //0.017
//        }
//
//        if event.touches(for: sender)?.first?.phase == .ended{
//            buttonTimer.invalidate()
//        }
//    }
    

// called by gesture recognizer
//    @objc func tapHandler(gesture: UITapGestureRecognizer) {
//        if gesture.state == .began {
//            buttonTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (Timer) in self.getPos2(gesture)})
//        } else if gesture.state == .ended { // optional for touch up event catching
//            buttonTimer.invalidate()
//        }
//    }
//
//    func getPos2 (_ sender: UITapGestureRecognizer){
////        for i in 0...(sender.numberOfTouches - 1) {
////            print(sender.location(ofTouch: i, in: self.MainView))
////        }
//
//        print(sender.numberOfTouches)
//
//    }
    
    var buttonTimer:Timer!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.endIndex)
        for touch in touches {
            getPos(touch, with: event)
            //buttonTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (Timer) in self.getPos(touch, with: event)}) //0.017
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            getPos(touch, with: event)
        }
    }
    
    func getPos (_ touch: UITouch, with event: UIEvent?){
        print("x:", Double(touch.location(in: self.view).x), "    y:", Double(touch.location(in: self.view).y), touch.location(in: self.view))
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
