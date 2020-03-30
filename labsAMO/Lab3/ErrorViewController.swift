//
//  ErrorViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 28.03.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var xTextField: UITextField!
    
    var formula: PossibleFormuls = .myVariant
    
    var aSegue: Double = 0.0
    var bSegue: Double = 2.0
    var countSegue: Int = 10
    
    var data: [(n: Int, deltaN: Double, deltaExactN: Double, k: Double)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = formula.rawValue
        hideKeyboard()
        setupTableView()
    }
    
    
    private func setupTableView() {
        tableView.register(UINib(nibName: Lab3CustomTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: Lab3CustomTableViewCell.identifier)
        tableView.insetsLayoutMarginsFromSafeArea = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func didPressOkButton(_ sender: UIButton) {
        
        let x = Double(xTextField.text ?? "") ?? 0.0
        data = getDeltaN(x: x, n: countSegue)
        tableView.reloadData()
    }
    
    
    private func getDeltaN(x: Double, n: Int) -> [(n: Int, deltaN: Double, deltaExactN: Double, k: Double)] {
        var resultDelta: [(n: Int, deltaN: Double, deltaExactN: Double, k: Double)] = []
        
        for n in 1...n {
            let inteerpolatedN = getInternolatedYPoint(formula: formula, a: aSegue, b: bSegue, countOfInterpolation: n, x: x)
            let inteerpolatedNPlus1 = getInternolatedYPoint(formula: formula, a: aSegue, b: bSegue, countOfInterpolation: n + 1, x: x)
            
            var valueFormula = 0.0
            switch formula {
            case .myVariant:
                valueFormula = 1 / (0.5 + pow(x, 2))
            case .sinx:
                valueFormula = sin(x)
            }
            
            let deltaN = (inteerpolatedN - inteerpolatedNPlus1)
            let deltaExactN = (inteerpolatedN - valueFormula)
            let k = (1 - (deltaExactN / deltaN))
            
            resultDelta.append((n: n, deltaN: deltaN, deltaExactN: deltaExactN, k: k))
        }
        
        return resultDelta
    }
}


extension ErrorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Lab3CustomTableViewCell.identifier) as? Lab3CustomTableViewCell  else { return UITableViewCell() }
        cell.separatorInset = .zero
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.nLabel.text = "N"
            cell.deltaNLabel.text = "Δn"
            cell.deltaNNLabel.text = "ΔexactN"
            cell.kLabel.text = "k"
            return cell
        }
        
        let part = data[indexPath.row - 1]
        
        cell.nLabel.text = "\(part.n)"
        cell.deltaNLabel.attributedText = part.deltaN.scientificFormatted
        cell.deltaNNLabel.attributedText = part.deltaExactN.scientificFormatted
        cell.kLabel.attributedText = part.k.scientificFormatted
        
        return cell
    }
}
