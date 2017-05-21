//
//  LoginViewController.swift
//  MHTwitterClient
//
//  Created by Melany Gulianovych on 5/21/17.
//  Copyright © 2017 Melany Gulianovych. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoMoveToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightOriginalConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHightSmallConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var buttonVontainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        buttonVontainer.layer.cornerRadius = 5
        
        buttonVontainer.alpha = 0
        titleLabel.alpha = 0
        subTitleLabel.alpha = 0
        
        UIApplication.shared.statusBarStyle = .lightContent
        // Do any additional setup after loading the view.
    }
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        logoVerticalConstraint.priority = 100
        logoMoveToTopConstraint.priority = 1000

        logoHeightOriginalConstraint.priority = 100
        logoHightSmallConstraint.priority = 1000

        
        UIView.animate(withDuration: 1.5) { 
            [weak self] in
            self?.view.layoutIfNeeded()
            
            self?.buttonVontainer.alpha = 1
            self?.titleLabel.alpha = 1
            self?.subTitleLabel.alpha = 1
            
            self?.buttonVontainer.frame = (self?.buttonVontainer.frame)!.offsetBy(dx: 0, dy: -20)
            self?.titleLabel.frame = (self?.titleLabel.frame)!.offsetBy(dx: 0, dy: -20)
            self?.subTitleLabel.frame = (self?.subTitleLabel.frame)!.offsetBy(dx: 0, dy: -20)
        }
    }
    
    @IBAction func onLoginButton() {
    
    }

    func addGradient() {
        let color1 = UIColor(colorLiteralRed: 42.0/255.0, green: 163.0/255.0, blue: 239.0/255.0, alpha: 1.0)
        let color2 = UIColor(colorLiteralRed: 68.0/255.0, green: 178.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        let color3 = UIColor(colorLiteralRed: 141.0/255.0, green: 192.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        let color4 = UIColor(colorLiteralRed: 224.0/255.0, green: 226.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        
        let gradientColors = [color1.cgColor, color2.cgColor, color3.cgColor, color4.cgColor]
        let gradientLocations: [CGFloat] = [0.0, 0.25, 0.75, 1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
