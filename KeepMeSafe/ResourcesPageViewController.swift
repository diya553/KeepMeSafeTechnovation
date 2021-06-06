//
//  ResourcesPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 5/28/21.
//  Copyright © 2021 Diya Hituvalli. All rights reserved.
//

import UIKit

class ResourcesPageViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //updateTextView()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func novaButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.trynova.org/who-we-are/")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func allianceButton(_ sender: UIButton) {
    }
    
    @IBAction func selfDefenseButton(_ sender: UIButton) {
    }
    
    @IBAction func ywcaButton(_ sender: Any) {
    }
    
    @IBAction func endCampusButton(_ sender: Any) {
    }
    
    /*
    func updateTextView() {
        let path = "https://www.trynova.org/who-we-are/"
        let text = textView.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "National Organization For Victim Assistance")
        let font = textView.font
        let textColor = textView.textColor
        textView.attributedText = attributedString
        textView.font = font
        textView.textColor = textColor
    }
 */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
