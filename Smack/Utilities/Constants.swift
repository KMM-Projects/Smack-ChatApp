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

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//URL CONSTANTS: HEROKU
let BASE_URL = "https://patrikchattest.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"

