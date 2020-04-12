//
//  MatrixEnterViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 12.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class MatrixEnterViewController: UIViewController, MatrixEnteredDelgate {
    

    @IBOutlet weak var matrixEnteredView: MatrixEnterView!
    
    var matrixToSegue: MatrixCustom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        matrixEnteredView.matrixSize = 3
        
        matrixEnteredView.delegate = self
    }
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        guard let resultVC = UIStoryboard(name: "Lab5", bundle: Bundle.main).instantiateViewController(withIdentifier: Lab5ViewController.identifier) as? Lab5ViewController else {
            return
        }
        
        resultVC.matrixFromSegue = matrixToSegue
        
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    func getAllMatrix(_ matrixEnterView: MatrixEnterView, matrix: MatrixCustom) {
//        print("here")
        matrixToSegue = matrix
    }
}
