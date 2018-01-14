//
//  MessageResponse.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 14.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//


import ObjectMapper

class MessageResponse: Mappable {
    
    var message: String?
    var timestamp: Int32?
    var nickname: String?
    var avatarUrl: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        timestamp <- map["timestamp"]
        nickname <- map["nickname"]
        avatarUrl <- map["avatarUrl"]
    }
    
    
}
