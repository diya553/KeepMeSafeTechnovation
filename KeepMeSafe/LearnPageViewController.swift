//
//  LearnPageViewController.swift
//  KeepMeSafe
//
//  Created by Diya Hituvalli on 4/2/20.
//  Copyright © 2020 Diya Hituvalli. All rights reserved.
//

import UIKit

class LearnPageViewController: UIViewController {
    
    
    @IBOutlet var _learnMenu: UITableView!
    
    let menuDisplayTitles = ["Self-Defense", "How to Avoid Dangerous Situations", "Sexual Assault Statistics", "What You Can Do to Stop Rape Culture"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _learnMenu.delegate = self
        _learnMenu.dataSource = self
        _learnMenu.tableFooterView = UIView()
    }
    
    private func presentLearnSelfDefensePageViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LearnSelfDefensePageViewController")
        present(viewController, animated: true, completion: nil)
    }
    
    private func presentHowToAvoidDangerousSituationsPageViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "HowToAvoidDangerousSituationsPageViewController")
        present(viewController, animated: true, completion: nil)
    }

    private func presentLearnStatisticsPageViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LearnStatisticsPageViewController")
        present(viewController, animated: true, completion: nil)
    }
    
    private func presentLearnWhatYouCanDoViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "LearnWhatYouCanDoViewController")
        present(viewController, animated: true, completion: nil)
    }

    
}
extension LearnPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = menuDisplayTitles[indexPath.row]
        if title == "Self-Defense"{
            presentLearnSelfDefensePageViewController()
        } else if title == "How to Avoid Dangerous Situations"{
            presentHowToAvoidDangerousSituationsPageViewController()
        } else if title == "Sexual Assault Statistics"{
            presentLearnStatisticsPageViewController()
        } else if title == "What You Can Do to Stop Rape Culture"{
            presentLearnWhatYouCanDoViewController()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "learnMenuTableViewCellIdentifier") as? UITableViewCell else { return UITableViewCell() }
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

     



