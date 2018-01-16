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
import ObjectMapper


class MessagesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageInputView: UIView!
    
    var messagesArray = [[String:AnyObject]]() //Array of dictionary
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title =  UserDefaults.standard.string(forKey: "nickname")
        
        //Constructing tableView.
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.tableview.estimatedRowHeight = 66.0
        self.tableview.separatorStyle = .none
        self.messageTextField.delegate = self
        
        self.tableview.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageTableViewCell")
        self.view.addSubview(self.tableview)
        
        bottomConstraint = NSLayoutConstraint(item: messageInputView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
//        MessageService.getMessages(completion:{
//            ([MessageResponse]) in
//            print([MessageResponse])
//        },failure: {
//
//        })
        
        self.getMessages()
        
        
        
    }

    @IBAction func send(_ sender: Any) {
        
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        let message = messageTextField.text!
        let avatarUrl = "https://image.ibb.co/bvmP2R/Whats_App_Image_2018_01_08_at_8_24_40_PM.jpg"
        
        let myMessage = ["nickname": nickname, "message": message , "timestamp": 12345678, "avatarUrl": avatarUrl] as [String : Any]
        
//        let myMessage = Message.init(message: messageTextField.text!, timestamp: 123123, nickname: "Alaattin", avatarUrl: "")
        self.messagesArray.append(myMessage as [String : AnyObject])
        
        tableview.reloadData()
        messageTextField.text = ""
        
        let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
        self.tableview.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
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
                
//                Mapper<MessageResponse>().mapArray(JSONArray: [responseJSON])
                
                let swiftyJsonVar = JSON(responseJSON)
                
//                var array:[MessageResponse] = Mapper<MessageResponse>().mapArray(JSONArray: [responseJSON])
//                Message.getMessages(swiftyJsonVar)
                
                if let responseArray = swiftyJsonVar["data"].arrayObject {
                    self.messagesArray = responseArray as! [[String:AnyObject]]
                }
                
//                print(self.messagesArray)
//                var dict = self.messagesArray[3]
//                let message =  dict["message"] as? String
//                print(dict)
                
                if self.messagesArray.count > 0 {
                    self.tableview.reloadData()
                }
                
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messageTextField.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var dict = self.messagesArray[indexPath.row]
        let timestamp:Int = dict["timestamp"] as! Int
        
        if timestamp == 12345678 {
            let myCell = Bundle.main.loadNibNamed("MyMessageTableViewCell", owner: self, options: nil)?.first as! MyMessageTableViewCell
            myCell.avatarImageView.loadImageUsingCache(withUrl: (dict["avatarUrl"] as? String)!)
            myCell.nameLabel.text = dict["nickname"] as? String
            myCell.bodyLabel.text = dict["message"] as? String
            myCell.selectionStyle = .none
            
            return myCell
        }else{
            let cell = Bundle.main.loadNibNamed("MessageTableViewCell", owner: self, options: nil)?.first as! MessageTableViewCell
            cell.avatarImageView.loadImageUsingCache(withUrl: (dict["avatarUrl"] as? String)!)
            cell.nameLabel.text = dict["nickname"] as? String
            cell.bodyLabel.text = dict["message"] as? String
            cell.selectionStyle = .none
            
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesArray.count
    }
    

    
    @objc func handleKeyboardNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                
                if isKeyboardShowing {
                    let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
                    self.tableview.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
                
            })
        }
    }
}

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}


