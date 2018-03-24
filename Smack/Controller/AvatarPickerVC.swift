//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Patrik Kemeny on 24/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { // UICollectionViewDelegateFlowLayout let you implement a grid-based layout

    //Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    //variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            //if we are eble to deque a cell and his identifier is "avatarCell" than
           cell.configureCell(index: indexPath.item, type:avatarType )
            return cell
            
        }
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28 //all animals pictures
    }
    

    @IBAction func segmentControllChanged(_ sender: Any) {
        if segmentControll.selectedSegmentIndex == 0 {
            //dark is selecter
            avatarType = .dark
        } else {
            avatarType = .light
        }
        collectionView.reloadData()
    }
    // to keep the Avatars nice smooth even and fluid we can work with the colom numbers etc depends what screen we are using
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColums: CGFloat = 3
        if UIScreen.main.bounds.width > 320 { //UIScreen.main.bounds.width = screensize
            numberOfColums = 4 //for big screens
        }
        //calculate the width and heght
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40 // sides
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColums-1) * spaceBetweenCells) / numberOfColums
        return CGSize(width: cellDimension, height: cellDimension)
    }
    //select the Avatar
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
     self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}
