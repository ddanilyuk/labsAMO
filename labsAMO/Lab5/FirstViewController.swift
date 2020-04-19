//
//  MatrixEnterViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 12.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var viewWithMatrixAndStepper: UIView!
    
    @IBOutlet weak var matrixEnteredView: MatrixView!
    
    var sliderValue: Int = 3 {
        didSet {
            stepperLabel.text = "\(sliderValue) x \(sliderValue + 1)"
            matrixEnteredView.subviews.forEach({ $0.removeFromSuperview() })
            matrixEnteredView.matrixSize = sliderValue
        }
    }

    let array: [[Double]] = [[7.09,  1.17, -2.23],
                             [0.43,  1.40, -0.62],
                             [3.21, -4.25,  2.13]]
    
//    let array: [[Double]] = [[7.09,  1.17, -2.23],
//                             [0.00,  0.00, -0.62],
//                             [7.09, -4.25,  2.13]]

    let arrayAnswers: [Double] = [-4.75, -1.05, 5.06]
    
    var matrixToSegue: MatrixCustom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matrixEnteredView.delegate = self
        hideKeyboard()
        setupButton()
        setupStepper()
        setupSegmentControl()
        
        matrixToSegue = MatrixCustom(dataDoubleArray: array, dataAnswers: arrayAnswers)
        imageView.isHighlighted = false
        viewWithMatrixAndStepper.isHidden = true
    }
            
    
    private func setupSegmentControl() {
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
    }
    
    
    private func setupStepper() {
        stepper.maximumValue = 5
        stepper.minimumValue = 2
        stepper.value = 3
        stepper.stepValue = 1
        matrixEnteredView.matrixSize = sliderValue
        matrixEnteredView.spacing = 3.0
    }
    
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            imageView.isHidden = false
            viewWithMatrixAndStepper.isHidden = true
            matrixToSegue = MatrixCustom(dataDoubleArray: array, dataAnswers: arrayAnswers)
        case 1:
            imageView.isHidden = true
            viewWithMatrixAndStepper.isHidden = false
        default:
            break
        }
    }
    
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        guard let resultVC = UIStoryboard(name: "Lab5", bundle: Bundle.main).instantiateViewController(withIdentifier: ResultViewController.identifier) as? ResultViewController else { return }
        
        resultVC.matrixFromSegue = matrixToSegue
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        sliderValue = Int(sender.value)
    }
}


extension FirstViewController: MatrixDelgate {
    
    func didMatrixChanged(_ matrixEnterView: MatrixView, matrix: MatrixCustom) {
        matrixToSegue = matrix
    }
}
