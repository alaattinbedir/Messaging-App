//
//  NetworkManager.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 24.02.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class NetworkManager: NSObject {
    static let sharedInstance = NetworkManager()
    private var sessionManager: SessionManager
    let baseURL = "https://jsonblob.com/api/"
    //    let baseURL = "http://dcomm.etiya.com/Dev-CommerceBackend/"
    
    private override init() {
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Clien-Version"] = "1.0"
        configuration.httpAdditionalHeaders = headers
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: CustomServerTrustPoliceManager()
        )
        
        self.sessionManager = manager
    }
    
    func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
    {
        
        guard Utilities.sharedInstance.isNetworkConnectivityAvailable() else {
            print("internet yok")
            return
        }
        
        self.sessionManager.request(baseURL + strURL).responseJSON { (responseObject) -> Void in
            //print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        guard Utilities.sharedInstance.isNetworkConnectivityAvailable() else {
            print("internet yok")
            return
        }
        
        self.sessionManager.request(baseURL + strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            //print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
}

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    public init() {
        super.init(policies: [:])
    }
}

