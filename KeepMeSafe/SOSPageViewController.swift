//
//  SOSPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 3/28/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit
import Speech

class SOSPageViewController: UIViewController {
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
  
    
    
    @IBOutlet var activateKeepMeSafeButton: UIButton!
    @IBOutlet var button911: UIButton!
    @IBOutlet var _tableView: UITableView!
    
    let menuDisplayTitles = ["Report", "Learn", "About Us"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.tableFooterView = UIView()
    }
    
    
 
    @IBAction func activateKeepMeSafe(_ sender: UIButton) {
        presentVoiceRecognitionTestPageViewController()
        
    }
    
    @IBAction func button911Call(_ sender: UIButton) {
        makePhoneCall(phoneNumber: "911")

    }
    

    private func presentLearnPageViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LearnPageViewController")
        present(viewController, animated: true, completion: nil)
    }
    private func presentReportPageViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ReportPageViewController")
        present(viewController, animated: true, completion: nil)
    }
    private func presentAboutUsPageViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "AboutUsPageViewController")
        present(viewController, animated: true, completion: nil)
    }
    private func presentVoiceRecognitionTestPageViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "VoiceRecognitionTestPageViewController")
        present(viewController, animated: true, completion: nil)
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
extension SOSPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = menuDisplayTitles[indexPath.row]
        if title == "Report"{
            presentReportPageViewController()
        } else if title == "Learn"{
            presentLearnPageViewController()
        }
        else if title == "About Us"{
            presentAboutUsPageViewController()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? UITableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = menuDisplayTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDisplayTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


 
