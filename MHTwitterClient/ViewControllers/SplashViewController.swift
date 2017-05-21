//
//  SplashViewController.swift
//  MHTwitterClient
//
//  Created by Melany Gulianovych on 5/21/17.
//  Copyright © 2017 Melany Gulianovych. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, TwitterLoginProtocol {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !appDelegate.splashDelay {
            delay(1.0, closure: {
                [weak self] in
                self?.continueLogin()
            })
        }
    }
    
    func goToLogin() {
        self.performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    func continueLogin() {
        appDelegate.splashDelay = false
        goToLogin()
    }
}
