//
//  ChatVC.swift
//  Smack
//
//  Created by Patrik Kemeny on 21/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //Outlets

    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var channelNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // ADD gesture recognizer for swipe back
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        // add and observer who is w8ting for the notification
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        //observer
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelecte(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        //check if we are logged in
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (succes) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        MessageService.instance.findAllChannel { (succes) in
            
        }
    }
    @objc func userDataDidChanged(_ notif: Notification){
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages() 
        } else {
            //pls login
            channelNameLbl.text = "Please log In"
        }
    }
    
    @objc func channelSelecte(_ notif: Notification){
        updateWithChannel()
        
    }
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (succes) in
            if succes {
                //do staf with channels
            }
        }
    }

}
