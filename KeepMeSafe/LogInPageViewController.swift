//
//  LogInPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/15/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI


class LogInPageViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Login"
        
        scrollView.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setUpGesture()
        setUpElements()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func setUpElements() {
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInButton)
    }
    
    
 
    @objc func keyboardWillShow(notification: NSNotification){
        guard let baseKeyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: baseKeyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0 , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
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
    

//when user presses return, keyboard will disappear
extension LogInPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

//keyboard will disappear based on gesture
extension LogInPageViewController {
    func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
}


extension LogInPageViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolling now...")
    }
}


