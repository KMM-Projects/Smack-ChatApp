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
    
    func returnUIColor(components: String) -> UIColor{
        // grab "avatarColor": "[0.188235294117647,0.576470588235294,0.317647058823529,1]", and return colors
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ") //skip this variables
        let comma = CharacterSet(charactersIn: ",")//scan to .
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a : NSString?
        scanner.scanUpToCharacters(from: comma, into: &r) // scan [0.188235294117647,
        // [skipp ...scan... and stop at , adn safe it into r as red
        scanner.scanUpToCharacters(from: comma, into: &g)
          scanner.scanUpToCharacters(from: comma, into: &b)
          scanner.scanUpToCharacters(from: comma, into: &a)
        // are still optional so we need to unwarp them
        
        let defaulColor = UIColor.lightGray // in case we fail
         guard let rUnwrapped = r else { return defaulColor}
         guard let gUnwrapped = g else { return defaulColor}
         guard let bUnwrapped = b else { return defaulColor}
         guard let aUnwrapped = a else { return defaulColor}
        //convert String to CGFloat
        let rCGfloat = CGFloat(rUnwrapped.doubleValue)
        let gCGfloat = CGFloat(gUnwrapped.doubleValue)
        let bCGfloat = CGFloat(bUnwrapped.doubleValue)
        let aCGfloat = CGFloat(aUnwrapped.doubleValue)
        //return the color
       
        let newUIColor = UIColor(displayP3Red: rCGfloat, green: gCGfloat, blue: bCGfloat, alpha: aCGfloat)
        
        return newUIColor
    }
    
    
    func logoutUser(){
        
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
        
    
}
