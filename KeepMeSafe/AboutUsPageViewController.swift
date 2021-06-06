//
//  AboutUsPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/4/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit

class AboutUsPageViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func instagramButton(_ sender: UIButton) {
        if let url = URL(string: "https://www.instagram.com/keepmesafeapp") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func websiteButto(_ sender: UIButton) {
        if let url = URL(string: "https://www.keepmesafecorp.org") {
            UIApplication.shared.open(url)
        }
    }


  
}
