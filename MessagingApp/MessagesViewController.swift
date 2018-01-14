//
//  ViewController.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 13.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

class MessagesViewController: UIViewController {

    var messagesArray = [[String:AnyObject]]() //Array of dictionary
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMessages() -> Void {
        Alamofire.request("https://jsonblob.com/api/jsonBlob/61d68d54-d93e-11e7-a24a-934385df7024")
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching data: \(response.result.error ?? "" as! Error)")
                    return
                }
                
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid data received from the service")
                    return
                }
                
                let swiftyJsonVar = JSON(responseJSON)
                
                if let responseArray = swiftyJsonVar["data"].arrayObject {
                    self.messagesArray = responseArray as! [[String:AnyObject]]
                }
                
                print(self.messagesArray)
                var dict = self.messagesArray[3]
                
                let message =  dict["message"] as? String
                print(message!)
                
//                if self.messagesArray.count > 0 {
//                    self.tblJSON.reloadData()
//                }
                
        }
    }
    
    
//    func getMessages(completion: @escaping ([String]) -> Void) {
//
////        let URL = "https://jsonblob.com/api/jsonBlob/61d68d54-d93e-11e7-a24a-934385df7024"
////        Alamofire.request(URL).responseArray { (response: DataResponse<[Message]>) in
////
////                guard response.result.isSuccess else {
////                    print("Error while fetching data: \(response.result.error ?? "" as! Error)")
////                    completion([String]())
////                    return
////                }
////
////                guard let responseJSON = response.result.value as? [String: Any] else {
////                    print("Invalid data received from the service")
////                    completion([String]())
////                    return
////                }
////
////                let messageArray = response.result.value
////
////                if let messageArray = messageArray {
////                    for message in messageArray {
////                        print(message.message)
////                    }
////                }
//
////                let swiftyJsonVar = JSON(response.result.value!)
////                print(swiftyJsonVar)
////
////                print(responseJSON)
////
////                if let resData = swiftyJsonVar["data"].arrayObject {
////
////                    for item in resData {
////                        //                        var messages = Message.init(json: item)
////                    }
////                    self.dataArray = resData
////                }
////
////                print(self.dataArray)
////
////                //                if self.arrRes.count > 0 {
////                //                    self.tblJSON.reloadData()
////                //                }
////
////                completion([String]())
//        }
//    }

}

