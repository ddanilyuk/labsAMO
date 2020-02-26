//
//  FirstTaskViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class FirstTaskViewController: UIViewController {
    
    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        setupButton()
    }
    
    
    @IBAction func didPressResultButton(_ sender: UIButton) {
        resultLabel.text = "Y1 = \(calculate(a: aTextField.text ?? "", c: cTextField.text ?? ""))"
    }
    
    
    func calculate(a: String, c: String) -> String {
        guard let doubleA = Double(a), let doubleC = Double(c) else { return "Числа введені не корректно" }

        if (doubleA - doubleC) < 0 {
            let alert = UIAlertController(title: nil, message: "Факторіал з мінусом!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Змінити значення", style: .default, handler: { (_) in
            }))
            
            self.present(alert, animated: true, completion: {
            })
            
            return "РЕЗУЛЬТАТ"
        }
        
        let part1 = ((pow(doubleA, 2) - pow(doubleC, 2)) / 7)
        let part2 = (factorial(doubleA) / (factorial(doubleC) * factorial(doubleA - doubleC)))
        let result = part1 + part2
                
        return String(result.rounded(digits: 3))
    }
    
    
    @IBAction func showGraphButton(_ sender: UIBarButtonItem) {
        
        guard let graphVC : GraphViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: GraphViewController.identifier) as? GraphViewController else { return }
        graphVC.image = UIImage(named: "lab1Graph1")
        
        present(graphVC, animated: true, completion: nil)
    }
    
    
    func factorial(_ n: Double) -> Double {
        if n == 0 {
            return 1
        }
        return n * factorial(n-1)
    }
    

}
