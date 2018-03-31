//
//  ChannelVC.swift
//  Smack
//
//  Created by Patrik Kemeny on 21/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate,UITableViewDataSource{
    //Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loginBtn: UIButton! // shoudl change when log in to user name
    //unwired Seque we want to jumt from CreateACCountVC to ChannelVC
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareForUnwind(seque: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        //the measure how much the rear view controller is show
        
        // add and observer who is w8ting for the notification
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil ) // always when this notification is than new account was created
        // we are listening and if that notification was bradcasted then we start function userDataDidChanged
        SocketService.instance.getChannel { (succes) in
            if succes { //if we recive a new channel
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
        
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
     setupUserInfo()
    }
    
    func setupUserInfo(){
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
    
    
 
    @IBAction func addChannelPressed(_ sender: Any) {
        
        let addChannel = AddChannelVC() //extend
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
       //comfort the table view protocol
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel =  MessageService.instance.channels[indexPath.row]//from message channel array
            cell.configureCell(channel: channel)
            return cell
        }
        else {
            return UITableViewCell() // retrun emptu tableViewCell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    
}
