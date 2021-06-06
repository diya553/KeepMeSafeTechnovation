//
//  SignUpLogInPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/16/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI

class SignUpLogInPageViewController: UIViewController {

    @IBOutlet weak var keepMeSafeLogo: UIImageView!
    @IBOutlet weak var keepMeSafeText: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setUpElements()
        authenticateUserAndConfigureView()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func authenticateUserAndConfigureView () {
        let currentUser = (Auth.auth().currentUser)
        print(currentUser?.email as Any)
        if Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                let sosPageViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.sosPageViewController) as? SOSPageViewController
                
                self.view.window?.rootViewController = sosPageViewController
                self.view.window?.makeKeyAndVisible()
                //                let navController = UINavigationController(rootViewController: LogInPageViewController())
                //                navController.navigationBar.barStyle = .black
                //                self.present(navController, animated: true, completion: nil)
            }
        }
        //        else { //user is there
        //            let sosPageViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.sosPageViewController) as? SOSPageViewController
        //
        //            self.view.window?.rootViewController = sosPageViewController
        //            self.view.window?.makeKeyAndVisible()
        //        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
    
