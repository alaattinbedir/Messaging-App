//
//  Utilities.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 16.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import Foundation

public class Utilities {
    
    public class var sharedInstance: Utilities {
        struct Singleton {
            static let instance : Utilities = Utilities()
        }
        return Singleton.instance
    }
    
    let manager = Utilities()
    
    init() {
    }
    
    //MARK: methods
    
//    func getArticles(page: Int = 1, completion: (articles: [Article]) -> ()) -> Request {
//        let router = ArticleRouter(endpoint: .GetArticles(page: page))
//
//        return manager.request(router)
//            .validate()
//            .responseJSON { (request, response, object, error) -> Void in
//                if let error = error {
//                    println(error)
//                    return;
//                }
//
//                let articleJson = ((object as! JSONDictionary)["articles"] as? [JSONDictionary])!
//
//                var objs: [Article] = []
//
//                for json in articleJson {
//                    objs += [Article(json: json)]
//                }
//
//                completion(articles: objs)
//        }
//    }
}
