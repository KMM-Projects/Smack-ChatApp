//
//  AuthService.swift
//  Smack
//
//  Created by Jonny B on 7/17/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
       
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                let json = try! JSON(data: data)
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue

               UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)

                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    //API Log in user request return just Email and Token
    
    //check out the postman the API have findUser by email request .. what is returning an User detail as name color avatar etc
    func findUserByEmail(completion: @escaping CompletionHandler){
        
        //Alamofire request check Postman
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    //dont violent the DRY principles
    func setUserInfo(data: Data){
        
        let json = try! JSON(data: data)
        let id = json["_id"].stringValue
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    }
    
    
    
    
    
    
}








//import Foundation
//import Alamofire
//import SwiftyJSON
////handling Login, register user etc
//
//class AuthService{
//
//    static let instance = AuthService() //accesible globali but just one in time
//    //persit data when the app lunch even when we reopen the app we are still live email-bc the data froms server and the token
//    let defaults = UserDefaults.standard      //check info right side
//    var isLoggedIn : Bool {
//        get{
//            //look into user defaults if it exist
//            return defaults.bool(forKey: LOGGED_IN_KEY)
//        }
//        set{
//            defaults.set(newValue, forKey: LOGGED_IN_KEY)
//        }
//    }
//    var authToken: String {
//        get{
//            return defaults.value(forKey: TOKEN_KEY) as!  String
//        }
//        set{
//            defaults.set(newValue, forKey: TOKEN_KEY)
//        }
//    }
//    var userEmail: String {
//        get{
//            return defaults.value(forKey: USER_EMAIL) as!  String
//        }
//        set{
//            defaults.set(newValue, forKey: USER_EMAIL)
//        }
//    }
//
//
////create webrequest func
////specify the headers, the bodies etc.
////using library alamofires - build on top of apple url session framework
//
//    func registerUser(email:String,password: String, completion: @escaping CompletionHandler ){
//
//        let lowerCaseEmail = email.lowercased()
//
//
//        //JSON object
//        //header
////        let header = [
////            "Content-Type": "application/json; charset=utf-8" //open postman you will see the same when open the header
////        ]
//        let body : [String: Any] = [
//            "email": lowerCaseEmail,
//            "password": password
//        ] //open postmnas open body the same
//
//        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in //rename to response in var response.
//            if response.result.error == nil {
//                completion(true) //this completion is completion: @escaping CompletionHandler custom made aliasing
//            } else {
//                completion(false)
//                debugPrint(response.result.error as Any)
//            }
//        }
//
//    }
//
//
//
//    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
//
//        let lowerCaseEmail = email.lowercased()
//
//        let body: [String: Any] = [
//            "email": lowerCaseEmail,
//            "password": password
//        ]
//
//        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
//
//            if response.result.error == nil {
//                guard let data = response.data else { return }
//                let json = try! JSON(data: data)
//                self.userEmail = json["user"].stringValue
//                self.authToken = json["token"].stringValue
//
//                self.isLoggedIn = true
//                completion(true)
//            } else {
//                completion(false)
//                debugPrint(response.result.error as Any)
//            }
//        }
//}
//}
//
//
////    func loginUser(email: String, password: String,completion: @escaping CompletionHandler ) {
////        //check the postmas the url is different but the headres are the same
////        //if you try this request in Postman we are recieving a JSON  naprk.
//////        {
//////            "user": "j4e@teksstrer.com",
//////            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVhYjQ1MzM4YjQ1N2UyY2Q3N2I2NjAwYSIsImlhdCI6MTUyMTg1NjQ1MywiZXhwIjoxNTI5NjMyNDUzfQ.8PGFT1PqpZtBtlvWUsot66JeaHqm1NdjEEZvZsNHd68"
//////        }
////        // a this we need to handle ===> JSON parsing
////        let lowerCaseEmail = email.lowercased()
////        //JSON object
////
////        let body : [String: Any] = [
////            "email": lowerCaseEmail,
////            "password": password
////        ] //open postmnas open body the same
////        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
////            //here we already recieve a response form the API
////            if response.result.error == nil {
////                //JSON
////
////                //inside respone.result is a JSON value
////                //so we can cast it as a Dictionary
//////                if let json = response.result.value  as? Dictionary<String,Any> //now we have a JSOn variable
//////                // check the "user": "j4e@teksstrer.com", part
//////                {
//////                    if let email = json["user"] as? String {
//////                        self.userEmail = email
//////                    }
//////                    if let token = json["token"] as? String {
//////                        self.authToken = token
//////                    }
//////                }
////
////                //USing SwiftyJSon
////                guard let data = response.data else {return}
////                let json = JSON(data:data) //now i have swiftyJson Obnject
////                self.userEmail = json["user"].stringValue
////                self.authToken = json["token"].stringValue
////
////                self.isLoggedIn = true
////                 completion(true)
////            } else {
////                completion(false)
////                debugPrint(response.result.error as Any)
////            }
////        }
////    }
////
////
////
////
////
////
////

