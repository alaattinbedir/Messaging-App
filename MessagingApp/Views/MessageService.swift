//
//  MessageService.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 16.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import Alamofire
import SwiftyJSON
import AlamofireObjectMapper
import ObjectMapper


public class MessageService {
    static let sharedInstance = MessageService()
    private var manager: SessionManager
    
    
    private init() {
        self.manager = Alamofire.SessionManager.default
    }
    
    func getMessages(completion:@escaping (Array<Message>) -> Void, failure:@escaping (Int, String) -> Void) -> Void{
        let url: String = "https://jsonblob.com/api/jsonBlob/61d68d54-d93e-11e7-a24a-934385df7024"
        
        self.manager.request(url).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                // get JSON return value and check its format
                guard let responseJSON = response.result.value as? [String: Any] else {
                    failure(0,"Error reading response")
                    return
                }
                
                // Convert to json
                let json = JSON(responseJSON)
                
                // Get json array  from data
                let array = json["data"].arrayObject
                
                // Map json array to Array<Message> object
                guard let messages:[Message] = Mapper<Message>().mapArray(JSONObject: array) else {
                    failure(0,"Error mapping response")
                    return
                }
                
                // Send to array to calling controllers
                completion(messages)
                
            case .failure(let error):
                failure(0,"Error \(error)")
            }
        }
    }
    
}
