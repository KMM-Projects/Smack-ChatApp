//
//  SocketService.swift
//  Smack
//
//  Created by Patrik Kemeny on 31/3/18.
//  Copyright © 2018 Patrik Kemeny. All rights reserved.
//

import Foundation
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    var socket: SocketIOClient = SocketIOClient(manager: URL(string: BASE_URL)!)
    
    func establishConnection() {
        socket.connect()
    }
    func closeConnection() {
        socket.disconnect()
    }
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
        //sent to API some information that the channel is created
    }
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in //ack - acknowledgement //check API indez.js
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelid = dataArray[2] as? String else {return}
            
        let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelid)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
        
    }
}
