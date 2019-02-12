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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if (UserDefaults.standard.string(forKey: "Layout")?.hasPrefix("defaultKeys"))! {
            if Int(String((UserDefaults.standard.string(forKey: "Layout")?.last)!))! <= 9{ //wtf
                return Int(String((UserDefaults.standard.string(forKey: "Layout")?.last)!))!
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
    
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (self.collectionView.frame.width - 20 - CGFloat(collectionView.numberOfItems(inSection: 0))*2) / CGFloat(collectionView.numberOfItems(inSection: 0)), height: (self.collectionView.frame.height) - 20)

//        print("True frame size is: width -", self.view.frame.size.width, "height -", self.view.frame.size.height)
//        print("Fixed frame size is: width -", (self.view.frame.size.width - 20 - CGFloat(collectionView.numberOfItems(inSection: 0))*10) / CGFloat(collectionView.numberOfItems(inSection: 0)), "height -", self.view.frame.size.height)
        
        //print(collectionView.frame)
        return size
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animateAlongsideTransition(in: view
            , animation: { (UIViewControllerTransitionCoordinatorContext) in
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
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

class ButtonControllerCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func keyDown(_ sender: UIButton) {
        ClickProcessor().keyDownToServer(sender.currentTitle!)
    }

    @IBAction func keyUp(_ sender: UIButton) {
        ClickProcessor().keyUpToServer(sender.currentTitle!)
    }
    
}
