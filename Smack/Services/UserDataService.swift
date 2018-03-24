//
//  UserDataService.swift
//  Smack
//
//  Created by Patrik Kemeny on 24/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import Foundation


class UserDataService{
    static let instance = UserDataService()
    
    public private(set) var id = "" // outside class can read but not set //encapsulating data
    public private(set) var avatarColor = ""
     public private(set) var avatarName = ""
     public private(set) var email = ""
     public private(set) var name = ""
 
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String){
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
}
