//
//  ViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class LabChooserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let labNames = ["Лабораторна №1", "Лабораторна №2", "Лабораторна №3", "Лабораторна №4", "Лабораторна №5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: MyTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: MyTableViewCell.identifier)
    }


}


extension LabChooserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labNames.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == labNames.count {
//            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "1")
//
//            cell.textLabel?.text = "Лабораторні виконав: ДАНИЛЮК Д.A"
//            cell.detailTextLabel?.text = "ІВ-82 | Номер у списку - 7"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
            
//            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "1")
            
            cell.textLabel?.text = labNames[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == labNames.count {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
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
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == labNames.count {
            return 90
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}

