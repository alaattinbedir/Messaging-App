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
    
    func getMessages(completion:@escaping (Array<MessageResponse>) -> Void, failure:@escaping (Int, String) -> Void) -> Void{
        let url: String = "https://jsonblob.com/api/jsonBlob/61d68d54-d93e-11e7-a24a-934385df7024"
        
        self.manager.request(url).validate(statusCode: 200..<300).responseJSON { response in
            switch response.result {
            case .success:
                //to get JSON return value
                guard let responseJSON = response.result.value as? Array<[String: AnyObject]> else {
                    failure(0,"Error reading response")
                    return
                }
                guard let messages:[MessageResponse] = Mapper<MessageResponse>().mapArray(JSONArray: responseJSON) else {
                    failure(0,"Error mapping response")
                    return
                }
                
                completion(messages)
            case .failure(let error):
                failure(0,"Error \(error)")
            }
        }
    }
    
    func printMyName() -> Void {
        print("Alaattin")
    }
    
}
