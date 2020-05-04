//
//  SignUpLogInPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/16/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit

class SignUpLogInPageViewController: UIViewController {

    @IBOutlet weak var keepMeSafeLogo: UIImageView!
    @IBOutlet weak var keepMeSafeText: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }

    
}
