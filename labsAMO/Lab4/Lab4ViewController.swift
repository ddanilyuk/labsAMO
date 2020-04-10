//
//  Lab4ViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 08.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

enum ResultError: LocalizedError {
    
    case functionIsNotHomogeneous
    
    case noRoots

    case iterationLimit
    
    case divisionByZero
    
    var errorDescription: String? {
        switch self {
        case .functionIsNotHomogeneous:
            return "Функція не монотонна"
        case .iterationLimit:
            return "Ліміт ітерацій"
        case .divisionByZero:
            return "Ділення на 0"
        case .noRoots:
            return "Немає коренів на цьому проміжку"
        }
    }
    
}

class Lab4ViewController: UIViewController {
    
    /// A textField
    @IBOutlet weak var aTextField: UITextField!
    
    /// B textField
    @IBOutlet weak var bTextField: UITextField!
    
    /// epsilon textField
    @IBOutlet weak var epsilonTextField: UITextField!
    
    /// Label with result
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        hideKeyboard()
        
        resultLabel.text = ""
    }
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        resultLabel.text = ""

        var alert: UIAlertController?
        
        guard let a = Double(aTextField.text ?? ""), let b = Double(bTextField.text ?? ""), let epsilon = Double(epsilonTextField.text ?? "") else {
            let alert = UIAlertController(title: "Помилка", message: "Введіть всі значення", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Змінити значення", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        do {
            let result = try getResult(a: a, b: b, epsilon: epsilon, function: myFunction, dFunction: myDFunction, ddFunction: myDDFunction)
            resultLabel.text = "x0 = \(result) \nf(x0) = \(myFunction(x: result))"

        } catch ResultError.divisionByZero {
            alert = UIAlertController(title: "Помилка", message: "Ділення на 0 (f`(x) = 0)", preferredStyle: .alert)
        } catch ResultError.noRoots {
            alert = UIAlertController(title: "Помилка", message: "На цьому проміжку немає коренів", preferredStyle: .alert)
        } catch ResultError.iterationLimit {
            alert = UIAlertController(title: "Помилка", message: "Максимальна кількість ітерацій", preferredStyle: .alert)
        } catch ResultError.functionIsNotHomogeneous {
            alert = UIAlertController(title: "Помилка", message: "Функція не є однорідною на проміжку [a, b]", preferredStyle: .alert)
        } catch {
            print("Unexpected error: \(error).")
        }
        
        if let alert = alert {
            alert.addAction(UIAlertAction(title: "Змінити значення", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func didPressGetGraph(_ sender: UIButton) {
        guard let graphVC = UIStoryboard(name: "Lab4", bundle: Bundle.main).instantiateViewController(withIdentifier: Lab4ChartViewController.identifier) as? Lab4ChartViewController else { return }
        
        guard let a = Double(aTextField.text ?? ""), let b = Double(bTextField.text ?? "") else {
            let alert = UIAlertController(title: "Помилка", message: "Введіть всі значення", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Змінити значення", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        graphVC.aSegue = a
        graphVC.bSegue = b
        
        self.navigationController?.pushViewController(graphVC, animated: true)
    }
    
    
    @IBAction func didPressFindRoots(_ sender: UIButton) {
        resultLabel.text = ""
        var array: [(Double, Double)] = []

        for start in stride(from: -10.0, to: 10.0, by: 0.5) {
            do {
                let _ = try getResult(a: start, b: start + 0.499, epsilon: 0.0001, function: myFunction, dFunction: myDFunction, ddFunction: myDDFunction)
                
                array.append((start, start + 0.499))
            } catch {
                
            }
        }
        
        resultLabel.text = "Корені функції знаходяться на проміжках: \n\(array.description)"
    }

}
