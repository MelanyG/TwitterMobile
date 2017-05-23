//
//  TwitterClient.swift
//  MHTwitterClient
//
//  Created by Melany Gulianovych on 5/22/17.
//  Copyright © 2017 Melany Gulianovych. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: URL(string:"https://api.twitter.com"), consumerKey: "z0jiBATAXvaoyHodN9pAlMcLB", consumerSecret: "dt2ruby2mFOKwK67fNF40ghhMb41GD9QnvEK5FbmSAJmYEiS2F")
    var loginSuccess: (()->())?
    var loginFailure: ((Error)->())?
    var delegate: TwitterLoginProtocol?
    
    func login(success: @escaping ()->(), failure: @escaping (Error)->()) {
        loginSuccess = success
        loginFailure = failure
        deauthorize()
        
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterClient://oauth"), scope: nil, success: { (requestToken) in
            let url = URL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=" + (requestToken?.token)!)
            UIApplication.shared.open(url!)
        }) { [weak self] (error)  in
            print("error: \(error?.localizedDescription)")
            self?.loginFailure?(error!)
        }
    }
    
    func handleOpenURL(url: URL) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.splashDelay = true
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/request_token", method: "POST", requestToken: requestToken, success: { [weak self] (accessToken) in
            self?.currentAccount(success: { [weak self] (user: User) in
                User.currentUser = user
                self?.delegate?.continueLogin()
                self?.loginSuccess?()
            }, failure: { [weak self] (error) in
                self?.loginFailure?(error)
            })
            
            self?.loginSuccess?()
            
        }) { [weak self] (error) in
            print("error: \(error?.localizedDescription)")
            self?.loginFailure?(error!)
        }
    }
    
    func currentAccount(success: @escaping (User)->(), failure: @escaping (Error)->()) {
    get("account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
        let userDictionary = response as! NSDictionary
        let user = User(dictionary: userDictionary)
        success(user)
    }) { (task, error) in
        print("error: \(error.localizedDescription)")
failure(error)
        }
    }
    
    func logOut() {
    User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.UserDidLogOutNotification), object: nil)
    }
}
