//
//  ButtonsController.swift
//  owo!kb
//
//  Created by Илья Добряков on 09/02/2019.
//  Copyright © 2019 Илья Добряков. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ButtonCell"

class ButtonsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillAppear), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if UserDefaults.standard.string(forKey: "Layout") == "defaultKeys"  {
            if UserDefaults.standard.integer(forKey: "ButtonsCount") <= 9 { //wtf
                return UserDefaults.standard.integer(forKey: "ButtonsCount")
            }else{
                return 0
            }
        } else {
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ButtonControllerCell
        cell.button.setTitle(UserDefaults.standard.string(forKey: ("ButtonKey" + String(indexPath.row + 1))), for: .normal)
        cell.button.layer.cornerRadius = 12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (self.collectionView.frame.width - 20 - CGFloat(collectionView.numberOfItems(inSection: 0))*2) / CGFloat(collectionView.numberOfItems(inSection: 0)), height: (self.collectionView.frame.height) - 20)
        return size
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.collectionView.reloadData()
        }) { (UIViewControllerTransitionCoordinatorContext) in
            self.collectionView.reloadData()
        }
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
}

class ButtonControllerCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func bigButtonAction(_ sender: UIButton, forEvent event: UIEvent) {
        ClickProcessor().BigButtonToServer(sender.currentTitle!, event.touches(for: sender)!.first!.phase as UITouch.Phase)
    }
}
