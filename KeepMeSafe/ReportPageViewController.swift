//
//  ReportPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/2/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit

class ReportPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnCallReport(_ sender: UIButton) {
        makePhoneCall(phoneNumber: "1-800-656-4673")
    }
    func makePhoneCall(phoneNumber: String) {
        guard let phoneURL = URL(string: "tel://" + phoneNumber) else { return }
        let alert = UIAlertController(title: ("Call " + phoneNumber + "?"), message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
            UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

}
