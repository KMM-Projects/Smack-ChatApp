//
//  ProfileVC.swift
//  Smack
//
//  Created by Patrik Kemeny on 25/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

  // Outlets
    
    @IBOutlet weak var bgView: UIView! //bc gesturerecognizer, if somebody tap on background we will dismiss the background
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        //dismiss the view
        self.dismiss(animated: true, completion: nil)
       
    }

  
    @IBAction func logOutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        // and send notification when user data chanhed
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil )
        dismiss(animated: true, completion: nil)
        
    }
    
    func setupView() {
        userName.text = UserDataService.instance.name
        userMail.text = UserDataService.instance.email
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        //if click on background than dismiss
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
