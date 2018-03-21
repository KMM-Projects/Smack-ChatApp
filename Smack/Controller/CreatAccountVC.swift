//
//  CreatAccountVC.swift
//  Smack
//
//  Created by Patrik Kemeny on 21/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class CreatAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func closedPressed(_ sender: Any) {
   performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
