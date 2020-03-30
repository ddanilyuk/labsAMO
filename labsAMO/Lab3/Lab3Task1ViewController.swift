//
//  Lab3Task1ViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 17.03.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit


class Lab3Task1ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var bTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    
    var pickerSelectedRow: Int = 0
    var selectedFormula: PossibleFormuls = .myVariant
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        hideKeyboard()
        setupPickerView()
    }

    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    

    @IBAction func didPressGetGraphicButton(_ sender: UIButton) {
        guard let graphVC = UIStoryboard(name: "Lab3", bundle: Bundle.main).instantiateViewController(withIdentifier: Lab3ChartViewController.identifier) as? Lab3ChartViewController else { return }
        
        graphVC.aSegue = Double(aTextField.text ?? "") ?? 0.0
        graphVC.bSegue = Double(bTextField.text ?? "") ?? 2.0
        graphVC.countSegue = Int(countTextField.text ?? "") ?? 10
        graphVC.formula = selectedFormula

        self.navigationController?.pushViewController(graphVC, animated: true)
    }
    
    
    @IBAction func didPressGetErrorButton(_ sender: UIButton) {
        guard let errorVC = UIStoryboard(name: "Lab3", bundle: Bundle.main).instantiateViewController(withIdentifier: ErrorViewController.identifier) as? ErrorViewController else { return }
        
        errorVC.aSegue = Double(aTextField.text ?? "") ?? 0.0
        errorVC.bSegue = Double(bTextField.text ?? "") ?? 2.0
        errorVC.countSegue = Int(countTextField.text ?? "") ?? 10
        errorVC.formula = selectedFormula
        
        self.navigationController?.pushViewController(errorVC, animated: true)
    }
}


extension Lab3Task1ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return PossibleFormuls.myVariant.rawValue
        } else {
            return PossibleFormuls.sinx.rawValue
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            selectedFormula = .myVariant
        } else {
            selectedFormula = .sinx
        }
    }
}



