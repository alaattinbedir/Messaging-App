//
//  Message.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 13.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import Foundation
import SwiftyJSON

class Message {
    var message: String
    var timestamp: Int32
    var nickname: String
    var avatarUrl: String
    var messages = [Any]()
    
    init(){
        self.message = ""
        self.timestamp = 0
        self.nickname = ""
        self.avatarUrl = ""
    }
        
    init(message: String, timestamp: Int32, nickname: String, avatarUrl: String) {
        self.message = message
        self.timestamp = timestamp
        self.nickname = nickname
        self.avatarUrl = avatarUrl
    }
    
    init(json : JSON){
        self.message = json["message"].stringValue
        self.timestamp = json["timestamp"].int32Value
        self.nickname = json["nickname"].stringValue
        self.avatarUrl = json["avatarUrl"].stringValue
    }
    
}

extension Message {
    
    func getMessages(json : JSON) -> [Array<Any>] {
        
        if let items = json["data"].arrayObject {
            for message in items {
                let item = Message.init(json: message as! JSON)
                messages.append(item)
            }
        }
        
        return [messages]
    }
}
