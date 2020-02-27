//
//  ThirdTaskViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit


class ThirdTaskViewController: UIViewController {

    @IBOutlet weak var nTextField: UITextField!
    @IBOutlet weak var aTextField: UITextField!
    
    @IBOutlet weak var aDetailLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        hideKeyboard()
    }
    
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        let n = Int(nTextField.text ?? "") ?? 0
        
        let splited = (aTextField.text ?? "").split(separator: ",")
        
        var arrayA: [Double] = []
        
        for part in splited {
            let trimmed = String(part).trimmingCharacters(in: .whitespacesAndNewlines)
            arrayA.append(Double(trimmed) ?? 0.0)
        }
        
        // Show array that user entered
        aDetailLabel.text = "[A] = \(arrayA.description)"

        // Show alert if n is bigger than array length
        if n > arrayA.count {
            let alert = UIAlertController(title: nil, message: "Кількість елементів массива менша за N", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Змінити значення", style: .default, handler: { (_) in
            }))
            self.present(alert, animated: true, completion: {
            })
            aDetailLabel.text = "[A] = \(arrayA.description)"
            return
        }
        
        var f = 0.0
        for i in 0..<n {
            var f1 = 1.0
            for j in 0..<n {
                f1 *= arrayA[i] + pow(arrayA[j], 2)
            }
            f += f1
        }
        resultLabel.text = "f = \(String(f.rounded(digits: 3)))"
    }
    
    
    @IBAction func didPressShowGraph(_ sender: UIBarButtonItem) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        guard let graphVC : GraphViewController = mainStoryboard.instantiateViewController(withIdentifier: GraphViewController.identifier) as? GraphViewController else { return }
        graphVC.image = UIImage(named: "lab1Graph3")
        present(graphVC, animated: true, completion: nil)
    }
    
    
    
    
}
