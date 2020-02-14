//
//  FirstTaskViewController.swift
//  lab1AMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class FirstTaskViewController: UIViewController {
    
    @IBOutlet weak var bTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
////        navigationController?.navigationItem.rightBarButtonItems =
//        self.navigationItem.rightBarButtonItem = add
        setupButton()

    }
    
    
    @IBAction func didPressResultButton(_ sender: UIButton) {
        resultLabel.text = "Y1 = \(calculate(b: bTextField.text ?? "", c: cTextField.text ?? ""))"
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let lab2 = UIStoryboard(name: "Lab2", bundle: Bundle.main)
        
        let storyBoards = [mainStoryboard, lab2]
        
        
        let some = storyBoards[1]
        
        
        let mainVC = some.instantiateInitialViewController()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let window = appDelegate?.window else { return }
        
        window.rootViewController = mainVC
    }
    
    
    func calculate(b: String, c: String) -> String {
        guard let doubleB = Double(b) else { return "Числа введені не корректно" }
        guard let doubleC = Double(c) else { return "Числа введені не корректно" }

        let part1 = ((doubleB * sqrt(doubleC)) / pow(2, doubleB))
        let part2 = ((doubleC * sqrt(doubleB)) / pow(2, doubleC))
        let result = part1 - part2
        
        return String(round(1000 * result)/1000)
    }

    
}
