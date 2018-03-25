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
    //unwired Seque we want to jumt from CreateACCountVC to ChannelVC
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareForUnwind(seque: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        //the measure how much the rear view controller is show
        
        // add and observer who is w8ting for the notification
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil ) // always when this notification is than new account was created
        // we are listening and if that notification was bradcasted then we start function userDataDidChanged
    }

    @IBAction func loginBtnPresse(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            //show profile page without any seque 
            let profile = ProfileVC() //extentionated
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
        performSegue(withIdentifier: TO_LOGIN, sender: nil) //when we are not loged in
        }
    }
    
    @objc func userDataDidChanged(_ notif: Notification){
        if AuthService.instance.isLoggedIn { // we are logged in
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            // setup color for userImage
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else { //if we are not loged in
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            
        }
    }
}
