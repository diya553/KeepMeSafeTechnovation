//
//  SplashViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 5/24/21.
//  Copyright © 2021 Diya Hituvalli. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        // Do any additional setup after loading the view.
        
        decideNavigation()
    }
    
    private func decideNavigation() {
        if Auth.auth().currentUser == nil {
            let navController = UINavigationController(rootViewController: SignUpLogInPageViewController())
            navController.navigationBar.barStyle = .black
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = navController
            //            DispatchQueue.main.async {
            //                let navController = UINavigationController(rootViewController: LogInPageViewController())
            //                navController.navigationBar.barStyle = .black
            //                self.present(navController, animated: true, completion: nil)
            //            }
        }
        else { //user is there
            let sosPageViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.sosPageViewController) as? SOSPageViewController
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = sosPageViewController
//            self.view.window?.rootViewController = sosPageViewController
//            self.view.window?.makeKeyAndVisible()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
