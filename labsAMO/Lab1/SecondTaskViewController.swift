//
//  SecondTaskViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class SecondTaskViewController: UIViewController {
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    @IBOutlet weak var bTextField: UITextField!
    @IBOutlet weak var kTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var xSignButton: UIButton!
    @IBOutlet weak var cSignButton: UIButton!
    @IBOutlet weak var bSignButton: UIButton!
    @IBOutlet weak var kSignButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
    }
    

    @IBAction func didPressResult(_ sender: UIButton) {
        guard let xSign = Double((xSignButton.titleLabel?.text ?? "") + "1") else { return }
        guard let cSign = Double((cSignButton.titleLabel?.text ?? "") + "1") else { return }
        guard let bSign = Double((bSignButton.titleLabel?.text ?? "") + "1") else { return }
        guard let kSign = Double((kSignButton.titleLabel?.text ?? "") + "1") else { return }
        
        let xNumber = xTextField.text ?? ""
        let cNumber = cTextField.text ?? ""
        let bNumber = bTextField.text ?? ""
        let kNumber = kTextField.text ?? ""

        let xDouble = (Double(xNumber) ?? 0) * xSign
        let cDouble = (Double(cNumber) ?? 0) * cSign
        let bDouble = (Double(bNumber) ?? 0) * bSign
        let kDouble = (Double(kNumber) ?? 0) * kSign

        var y = 0
        
        if xDouble > 0 {
            y = Int(kDouble * pow(xDouble, 2) + cDouble * xDouble + bDouble)
        } else {
            y = Int(bDouble * pow(xDouble, 2) + cDouble * xDouble + kDouble)
        }

        resultLabel.text = "y = \(y)"
    }
    
    @IBAction func didPressChangeXSign(_ sender: UIButton) {
        changeSign(xSignButton)
    }
    
    @IBAction func didPressChaneCSign(_ sender: UIButton) {
        changeSign(cSignButton)
    }
    
    @IBAction func didPressChangeBSign(_ sender: UIButton) {
        changeSign(bSignButton)
    }
    
    @IBAction func didPressChangeKButton(_ sender: UIButton) {
        changeSign(kSignButton)
    }
    
    func changeSign(_ buttton: UIButton) {
        if buttton.title(for: .normal) == "+"{
            buttton.setTitle("-", for: .normal)
        } else {
            buttton.setTitle("+", for: .normal)
        }
    }
}
