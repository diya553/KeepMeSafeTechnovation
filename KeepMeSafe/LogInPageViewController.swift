//
//  LogInPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/15/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInPageViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    
    func setUpElements() {
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
    }
 
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    // Couldn't sign in
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    
                    let sosPageViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.sosPageViewController) as? SOSPageViewController
                    
                    self.view.window?.rootViewController = sosPageViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }

}
