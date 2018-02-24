//
//  Message.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 14.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//


import ObjectMapper
import Alamofire
import SwiftyJSON

class Message: Mappable {
    
    var message: String?
    var timestamp: Int32?
    var nickname: String?
    var avatarUrl: String?
    var type:UInt8 = 0  
    
    init(message: String, timestamp: Int32, nickname: String, avatarUrl: String, type:UInt8) {
        self.message = message
        self.timestamp = timestamp
        self.nickname = nickname
        self.avatarUrl = avatarUrl
        self.type = type
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        timestamp <- map["timestamp"]
        nickname <- map["nickname"]
        avatarUrl <- map["avatarUrl"]
    }
}

extension Message {
    // Get messages from service
    static func getMessages(success:@escaping (Array<Message>) -> Void, failure:@escaping (String) -> Void) -> Void{
        
        NetworkManager.sharedInstance.requestGETURL("jsonBlob/61d68d54-d93e-11e7-a24a-934385df7024", success: { (responseJSON) in
            
            // Convert to json
            let json = JSON(responseJSON)
            
            // Get json array  from data
            let array = json["data"].arrayObject
            
            // Map json array to Array<Message> object
            guard let messages:[Message] = Mapper<Message>().mapArray(JSONObject: array) else {
                failure("Error mapping response")
                return
            }
            
            // Send to array to calling controllers
            success(messages)
            
        },failure: { (error) in
            failure(error as! String)
        })
        
    }
}
