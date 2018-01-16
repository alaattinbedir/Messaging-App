//
//  MessagesViewController.swift
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

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageInputView: UIView!
    
    var messagesArray = [Message]()
    let nickname = UserDefaults.standard.string(forKey: "nickname")
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title with nickname
        self.title =  nickname
        
        // Setting tableView
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 66.0
        self.tableView.separatorStyle = .none
        self.tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageTableViewCell")
        self.view.addSubview(self.tableView)
        
        // Setting textField
        self.messageTextField.delegate = self
        self.messageTextField.keyboardType = UIKeyboardType.alphabet
        self.messageTextField.returnKeyType = UIReturnKeyType.send
        
        // Set bottom constraint to move tableview and input panel smoothly.
        bottomConstraint = NSLayoutConstraint(item: messageInputView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        // Listen show/hide keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Get messages from service
        MessageService.sharedInstance.getMessages(completion: { (messages) in
            self.messagesArray = messages
            if self.messagesArray.count > 0 {
                self.tableView.reloadData()
            }
        }) { (code, error) in
            self.showMessage(message: error)
        }
        
    }

    fileprivate func showMessage(message : String) {
        let alert = UIAlertController(title: "Alert",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func sendMessage() {
        let message = messageTextField.text!
        
        if message.count == 0 {
            showMessage(message: "Please enter a text..")
            return
        }
        
        let avatarUrl = "https://image.ibb.co/bvmP2R/Whats_App_Image_2018_01_08_at_8_24_40_PM.jpg"

        // Create my message and add to messages array to show in the list
        // type = 1 for my messages
        let myMessage = Message(message: message, timestamp: 12345678, nickname: nickname!, avatarUrl: avatarUrl, type: 1)
        self.messagesArray.append(myMessage)
    }
    
    fileprivate func refreshTableView() {
        tableView.reloadData()
        messageTextField.text = ""
        
        // move scroll to last item on the tableview
        let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    @IBAction func send(_ sender: Any) {
        sendMessage()
        refreshTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // hide keyboard when user touch the tableview
        messageTextField.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = self.messagesArray[indexPath.row]
        if message.type == 1 {
            let myCell = Bundle.main.loadNibNamed("MyMessageTableViewCell", owner: self, options: nil)?.first as! MyMessageTableViewCell
            myCell.avatarImageView.loadImageUsingCache(withUrl: message.avatarUrl!)
            myCell.nameLabel.text = message.nickname
            myCell.bodyLabel.text = message.message
            myCell.selectionStyle = .none
            
            return myCell
        }else{
            let cell = Bundle.main.loadNibNamed("MessageTableViewCell", owner: self, options: nil)?.first as! MessageTableViewCell
            cell.avatarImageView.loadImageUsingCache(withUrl: message.avatarUrl!)
            cell.nameLabel.text = message.nickname
            cell.bodyLabel.text = message.message
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.returnKeyType==UIReturnKeyType.send)
        {
            // Dismiss the keyboard
            textField.resignFirstResponder()
            sendMessage()
            refreshTableView()
        }
        return true
    }
    
    @objc func handleKeyboardNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                // To move keyboard and input panel together invoke layoutIfNeeded method
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                
                if isKeyboardShowing {
                    // Scroll to last item on the tableview after keyboard has shown 
                    let indexPath = IndexPath(item: self.messagesArray.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
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




