//
//  CircleImage.swift
//  Smack
//
//  Created by Patrik Kemeny on 25/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit


@IBDesignable

class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }

    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2 //if we assume that is a square than it will be a circle /collection we set up square
        self.clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
