//
//  User.swift
//  MHTwitterClient
//
//  Created by Melany Gulianovych on 5/22/17.
//  Copyright © 2017 Melany Gulianovych. All rights reserved.
//

import UIKit

class User {
    static let UserDidLogOutNotification = "UserDidLogOut"
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
    }
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUser") as? NSData
                
                if let userdata = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userdata as Data, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user, options: [])
                defaults.set(data, forKey: "currentUser")
            } else {
                defaults.set(nil, forKey: "currentUser")
            }
        }
    }
}
