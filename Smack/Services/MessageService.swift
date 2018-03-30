//
//  File.swift
//  Smack
//
//  Created by Patrik Kemeny on 30/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance  = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannel(completion: @escaping CompletionHandler){
        Alamofire.request(URL_GET_CHANNELS,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                //new Swift 4 parsing aproach   -  decoable protocol in model
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error as Any)
//                }
//                print(self.channels)
//
                
                // old style of parsing
                // but we want JSON array
                if let Json = try! JSON(data: data).array {
                    for item in Json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle:name, channelDescription: channelDescription, id:id)
                        self.channels.append(channel)
                    }
                    completion(true)

                }
                
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
}
