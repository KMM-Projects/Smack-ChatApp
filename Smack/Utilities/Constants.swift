//
//  Constants.swift
//  Smack
//
//  Created by Patrik Kemeny on 21/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

//use this file for Seque identifiers etc
//just constants


import Foundation

typealias  CompletionHandler = (_ Success: Bool) -> () //CompletionHandler is alias Suce... what is a slosure
// closure *((_ Success: Bool) -> ())* is first past function  for example we send a request to the server and depends on the
//answer we can slosure it as True Or false, was it succesfull or not  
// check the func registerUSer in AuthService.swift 
//remaping the type for example
//typealias  Patrik = String
//let name: Patrik = "Kememy"

//URL CONSTANTS: HEROKU
let BASE_URL = "https://patrikchattest.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//HEADERS
let HEADER = [
    "Content-Type": "application/json; charset=utf-8" 
]
// Colors Constant
let smackPurplePlaceHolder =  #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 0.5)

// Notification contants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataC hanged")







