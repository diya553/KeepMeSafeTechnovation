//
//  Resources2PageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 5/30/21.
//  Copyright © 2021 Diya Hituvalli. All rights reserved.
//

import UIKit

class Resources2PageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func victimAssistanceButton(_ sender: UIButton) {
        if let url = URL(string: "https://www.trynova.org/who-we-are/") {
            UIApplication.shared.open(url)
        }
    }
    
   
    
    @IBAction func bartCampaignButton(_ sender: UIButton) {
        if let url = URL(string: "https://www.bart.gov/guide/safety/gbv/campaign") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func selfDefenseButton(_ sender: UIButton) {
        if let url = URL(string: "https://www.malikah.org/self-defense") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func ywcaButton(_ sender: UIButton) {
        makePhoneCall(phoneNumber: "18005722782")

    }
    
    @IBAction func endCampusButton(_ sender: UIButton) {
        if let url = URL(string: "http://www.endrapeoncampus.org/") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func safeChatButton(_ sender: UIButton) {
        if let url = URL(string: "https://safechatsv.org") {
            UIApplication.shared.open(url)
        }
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
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
