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
    
    var sliderValue: Int = 3 {
        didSet {
            stepperLabel.text = "\(sliderValue) x \(sliderValue)"
            matrixEnteredView.subviews.forEach({ $0.removeFromSuperview() })
            matrixEnteredView.matrixSize = sliderValue
        }
    }

    
    let array: [[Double]] = [[7.09,  1.17, -2.23],
                             [0.43,  1.40, -0.62],
                             [3.21, -4.25,  2.13]]

    let arrayAnswers: [Double] = [-4.75, -1.05, 5.06]
    
    
    @IBOutlet weak var matrixEnteredView: MatrixView!
    
    var matrixToSegue: MatrixCustom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        setupButton()
        setupStepper()
        
        matrixToSegue = MatrixCustom(dataDoubleArray: array, dataAnswers: arrayAnswers)

        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.white]

        segmentControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
        
        imageView.isHighlighted = false
        viewWithMatrixAndStepper.isHidden = true
        
        
        matrixEnteredView.delegate = self
    }
        
    
    private func setupMatrixView() {
        
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
        guard let resultVC = UIStoryboard(name: "Lab5", bundle: Bundle.main).instantiateViewController(withIdentifier: ResultViewController.identifier) as? ResultViewController else {
            return
        }
        if matrixToSegue == nil {
            matrixToSegue = MatrixCustom(rows: sliderValue, columns: sliderValue)
        }
        resultVC.matrixFromSegue = matrixToSegue
        
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    
    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        if Int(sender.value) != sliderValue {
            sliderValue = Int(sender.value)
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {

        sliderValue = Int(sender.value)
//        MatrixCustom.maximumValue = 0.0
    }
}


extension FirstViewController: MatrixDelgate {
    
    func didMatrixChanged(_ matrixEnterView: MatrixView, matrix: MatrixCustom) {
        matrixToSegue = matrix
//        print("in didMatrixChanged = ", matrixToSegue?.maximum ?? 0.0)
    }
    
}
