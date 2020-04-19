//
//  Lab5ViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 10.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }
    
    var mainString = String()
    
    var matrixFromSegue: MatrixCustom?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.alpha = 0.0
        setupMatrix()
    }
    
    
    private func setupMatrix() {
        guard let matrix = matrixFromSegue else { return }
        
        /// Setup FontSize
        if matrix.columns == 5 {
            textView.font = UIFont(name:"Menlo-Regular", size: 16)
        } else if matrix.columns == 4 {
            textView.font = UIFont(name:"Menlo-Regular", size: 18)
        } else {
            textView.font = UIFont(name:"Menlo-Regular", size: 20)
        }

        mainString += "    Початкова матриця\n"
        mainString += matrix.description

        let result = gauss(matrix: matrix)
        
        mainString += "\n    Отримання результатів\n"
        for i in 0..<result.count {
            mainString += "  x\(i + 1) = \(result[i].rounded(digits: 6))\n"
        }

        textView.text = mainString
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.8, animations: {
            self.textView.alpha = 1.0
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.setAnimationsEnabled(false)
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.setAnimationsEnabled(false)
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(true)
    }
    
    
    /// To fix problem with offset
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    
    /**
    Gauss algorithm
     
     - Parameter matrix : Start matrix with answers
     - Parameter numIter: Parameter for recursion
     
     - Returns: Array with answers ([X])
        
    */
    func gauss(matrix: MatrixCustom, numIter: Int = 0) -> [Double] {
        if numIter == matrix.rows - 1 {
            return reverseGauss(matrixAfterGaussMethod: matrix)
        }
        
        let matrixToEdit = matrix.copy()
        
        let divider = matrixToEdit[numIter, numIter]
        
        if divider == 0 {
            let rowNumberWithMaxValue = matrixToEdit.findAbsMaxInColumn(column: numIter, from: numIter).rowNumber
            
            mainString += "\nОскільки дільник [\(numIter + 1), \(numIter + 1)] дорівнює 0\nВізьмемо рядок \(rowNumberWithMaxValue) з найбілшим значенням та переставим його\n"

            /// Make transposition
            let removedLineAndAnswer = matrixToEdit.removeRow(index: rowNumberWithMaxValue)
            matrixToEdit.insertRow(row: removedLineAndAnswer.row, answer: removedLineAndAnswer.answer, in: numIter)
            
            mainString += "\n    \(numIter + 1) Крок\n"
            mainString += matrixToEdit.description
            return gauss(matrix: matrixToEdit, numIter: numIter + 1)
        }
        
        for i in numIter + 1..<matrix.rows {
            let M = matrixToEdit[i, numIter] / divider
            
            let _ = matrixToEdit.removeRow(index: i)
            
            let (row, answer) = matrix.getRow(index: numIter)
            let (rowNext, answerNext) = matrix.getRow(index: i)

            matrixToEdit.insertRow(row: makeStep(row: row, nextRow: rowNext, M: M),
                                   answer: (answerNext - M * answer),
                                   in: i)
        }
        mainString += "\n    \(numIter + 1) Крок\n"
        mainString += matrixToEdit.description
        
        return gauss(matrix: matrixToEdit, numIter: numIter + 1)
    }
    
    
    /**
     Reverse
     
     - Parameter matrix: MatrixAfterGaussMethod
     
     - Returns: Array with answers ([X])
     
     */
    func reverseGauss(matrixAfterGaussMethod matrix: MatrixCustom) -> [Double] {
        /// Array like [0.0, 0.0, 0.0]
        var resultArray: [Double] = Array(repeating: 0.0, count: matrix.rows)
        
        for i in stride(from: matrix.rows - 1, to: -1, by: -1) {
            var sum = 0.0
            for j in 0..<matrix.columns {
                if i != j {
                    sum += matrix[i, j] * resultArray[j]
                }
            }
            
            let currentLineResult = (matrix.dataAnswers[i] - sum) / matrix[i, i]
            
            resultArray.remove(at: 0)
            resultArray.insert(currentLineResult, at: i)
        }
        
        return resultArray
    }
    
    
    /**
     Get new line from 2 lines
     
     - Parameter row: Main row
     - Parameter nextRow: Second row
     - Parameter M: M
     
     - Returns: New row
     
     */
    func makeStep(row: [Double], nextRow: [Double], M: Double) -> [Double] {
        
        var result: [Double] = []
        
        for i in 0..<nextRow.count {
            let elementOfNextLine = nextRow[i]
            let elementOfCurrentLine = row[i]
            
            result.append((elementOfNextLine - M * elementOfCurrentLine).rounded(digits: 8))
        }
        return result
    }
}
