//
//  CreatAccountVC.swift
//  Smack
//
//  Created by Patrik Kemeny on 21/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import UIKit

class CreatAccountVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor: UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    //when apear this view with picket Avatar
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
                
            }
        }
    }

    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.stopAnimating()
        //check Postman - for creating user we are sending just the emaila and the password
        guard let name = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                //print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                //send out notification that we created an user succesfully
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        //randomly generated UIcolor
        let r = CGFloat(arc4random_uniform(255))/255 //randomly generate number from 0-255 and then divide by 255
        let g = CGFloat(arc4random_uniform(255))/255
        let b = CGFloat(arc4random_uniform(255))/255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.6){
             self.userImg.backgroundColor = self.bgColor
        }
       
    }
    @IBAction func closedPressed(_ sender: Any) {
   performSegue(withIdentifier: UNWIND, sender: nil)
    }
    // we want the placeholder text to have blue color not gray
    func setupView(){
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
         emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
         passTxt.attributedPlaceholder = NSAttributedString(string: "passwork", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        
        // the keyboard is coverin the create acc button
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreatAccountVC.handleTap) )
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true) // textfiedl/view/if we have a keyboard open=tab it dissmis it for us
        
    }
    
}
