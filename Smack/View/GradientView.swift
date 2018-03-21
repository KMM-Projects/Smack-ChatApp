//
//  GradientView.swift
//  Smack
//
//  Created by Patrik Kemeny on 21/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

@IBDesignable //we are working inside the sotryboard

class GradientView: UIView {

    //create a variable wich camn be change inside the storyboard
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var BottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
            //setNeedslayout is calling the function layoutSubiews()
        }
    }
    override func layoutSubviews() {
        //here we are creating our new  layer
        let gradientLayer = CAGradientLayer()
        //its need starting end ending point, know the shape to fill,
        gradientLayer.colors = [topColor.cgColor, BottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) //start left top corner
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) //end right bottom corner
        gradientLayer.frame = self.bounds // size
        // add layer
        self.layer.insertSublayer(gradientLayer, at: 0) // insret layer as 0 layer
        
    }

}
