//
//  SignUpPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/15/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpPageViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sign Up"
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setUpGesture()
        setUpElements()
        scrollView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    func setUpElements() {
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if Utilities.isPasswordValid(cleanedPassword) == false {
                // Password isn't secure enough
                return "Please make sure your password is at least 8 characters, contains a special character and a number."
            }
            
            return nil
        }
 
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            
            showError(error!)
    }
        else {
        
        // Create cleaned versions of the data
        let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            // Check for errors
            if err != nil {
                
                // There was an error creating the user
                self.showError("Error creating user")
            }
            else {
                
                // User was created successfully, now store the first name and last name
                let db = Firestore.firestore()
                
                db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                    
                    if error != nil {
                        // Show error message
                        self.showError("Error saving user data")
                    }
                }
                
                self.transitionToHome()
            }
        }
    }
}
    
    func showError(_ message:String) {
            
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        
        let sosPageViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.sosPageViewController) as? SOSPageViewController
        
        view.window?.rootViewController = sosPageViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    
}
//when user presses return, keyboard will disappear
extension SignUpPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

//keyboard will disappear based on gesture
extension SignUpPageViewController {
    func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
}

extension SignUpPageViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolling now...")
    }
}

