//
//  Channel.swift
//  Smack
//
//  Created by Patrik Kemeny on 30/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import Foundation


struct  Channel: Decodable{
    //if using Decobale we order need to be the same as in JSON response
    public private(set) var channelTitle: String!
    public private(set) var channelDescription:String!
    public private(set) var id: String!
    
       // new way
    //    public private(set) var _id: String!
    //    public private(set) var name: String!
    //    public private(set) var description:String!
    //    public private(set) var __v: Int?
    

}
