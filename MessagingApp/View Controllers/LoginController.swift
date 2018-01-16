//
//  LoginController.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 14.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.string(forKey: "nickname") != nil) {
            performSegue(withIdentifier: "MessagesSegue", sender: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func showMessage() {
        let alert = UIAlertController(title: "Alert",
                                      message: "Please enter your nickname greater than 2 characters",
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
    
    @IBAction func login(_ sender: Any) {
        
        let nickName:String = nickNameTextField.text!
        
        // store nick name
        UserDefaults.standard.set(nickName, forKey: "nickname")  
        
        if nickName.count > 2 {
            performSegue(withIdentifier: "MessagesSegue", sender: nil)
        }else{
            showMessage()
        }
        
    }
    
    
}
