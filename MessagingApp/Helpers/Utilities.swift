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
    

}
