//
//  ViewController.swift
//  lab1AMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let labNames = ["Лабораторна 1", "Лабораторна 2", "Лабораторна 3", "Лабораторна 4", "Лабораторна 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "1")
        
        cell.textLabel?.text = labNames[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let lab2 = UIStoryboard(name: "Lab2", bundle: Bundle.main)
        
        let storyBoards = [mainStoryboard, lab2]
        
        
        let some = storyBoards[indexPath.row]
        
        
        let mainVC = some.instantiateInitialViewController()
        
        mainVC?.modalTransitionStyle = .crossDissolve
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let window = appDelegate?.window else { return }
        
        window.rootViewController = mainVC
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve

        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.4

        // Creates a transition animation.
        // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
        { completed in
            // maybe do something on completion here
        })
        
//        if let window = appDelegate?.window {
////            let loginVC = loginStoryboard.instantiateInitialViewController()
//            
//            //window.rootViewController = mainVC
//            
//        }
        
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let vc : UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: UITabBarController.identifier) as? UITabBarController else { return }
        

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

