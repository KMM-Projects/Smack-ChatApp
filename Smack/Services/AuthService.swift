//
//  AuthService.swift
//  Smack
//
//  Created by Patrik Kemeny on 22/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import Foundation
import Alamofire
//handling Login, register user etc

class AuthService{
    
    static let instance = AuthService() //accesible globali but just one in time
    //persit data when the app lunch even when we reopen the app we are still live email-bc the data froms server and the token
    let defaults = UserDefaults.standard      //check info right side
    var isLoggedIn : Bool {
        get{
            //look into user defaults if it exist
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    var authToken: String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as!  String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail: String {
        get{
            return defaults.value(forKey: USER_EMAIL) as!  String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }


//create webrequest func
//specify the headers, the bodies etc.
//using library alamofires - build on top of apple url session framework
  
    func registerUser(email:String,password: String, completion: @escaping CompletionHandler ){
        
        let lowerCaseEmail = email.lowercased()
        
        
        //JSON object
        //header
        let header = [
            "Content-Type": "application/json; charset=utf-8" //open postman you will see the same when open the header
        ]
        let body : [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ] //open postmnas open body the same
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in //rename to response in var response.
            if response.result.error == nil {
                completion(true) //this completion is completion: @escaping CompletionHandler custom made aliasing
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    

}




