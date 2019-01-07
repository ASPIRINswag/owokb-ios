	//
//  HideKeyboardExtention.swift
//  GeodesyCalc
//
//  Created by Илья Добряков on 23/08/2018.
//  Copyright © 2018 Илья Добряков. All rights reserved.
//

import UIKit

final public class KeyboardHideManager: NSObject {
        
    @IBOutlet internal var targets: [UIView]! {
        didSet {
            for target in targets {
                addGesture(to: target)
            }
        }
    }
        
    internal func addGesture(to target: UIView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        target.addGestureRecognizer(gesture)
    }
        
    @objc internal func dismissKeyboard() {
        targets.first?.topSuperview?.endEditing(true)
    }
}
    
extension UIView {
    internal var topSuperview: UIView? {
        var view = superview
        while view?.superview != nil {
            view = view!.superview
        }
        return view
    }
}
