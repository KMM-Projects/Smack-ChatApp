//
//  ChannelVC.swift
//  Smack
//
//  Created by Patrik Kemeny on 21/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    //Outlets
    
    @IBOutlet weak var loginBtn: UIButton! // shoudl change when log in to user name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        //the measure how much the rear view controller is show
    }

    @IBAction func loginBtnPresse(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
