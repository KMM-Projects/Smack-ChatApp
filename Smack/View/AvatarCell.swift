//
//  AvatarCellCollectionViewCell.swift
//  Smack
//
//  Created by Patrik Kemeny on 24/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    //Outlets
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
}
