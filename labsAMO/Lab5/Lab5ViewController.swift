//
//  Lab5ViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 10.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class Lab5ViewController: UIViewController {
    
    let array: [[Double]] = [[7.09,  1.17, -2.23],
                             [0.43,  1.40, -0.62],
                             [3.21, -4.25,  2.13]]

    let arrayAnswers: [Double] = [-4.75, -1.05, 5.06]
    
    var mainString = String()
    
    @IBOutlet weak var textView: UITextView!
    
    var matrixFromSegue: MatrixCustom?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        hideKeyboard()
        
//        textView.font = UIFont(name:"TrebuchetMS", size: 25)
        textView.font = UIFont(name:"MalayalamSangamMN", size: 25)
        
        guard let matrix = matrixFromSegue else {
            return
        }
//        let myMatrix = MatrixCustom(dataDoubleArray: array, dataAnswers: arrayAnswers)
        
        mainString += "    Start matrix \n"
        
        mainString += matrix.description
        
        let result = gauss(matrix: matrix)
        mainString += "\n"
        for i in 0..<result.count {
            mainString += "  x\(i + 1) = \(result[i].rounded(digits: 6))\n"
            print("x\(i + 1) = \(result[i])")
        }
        
        textView.text = mainString

    }
    
    
    func gauss(matrix: MatrixCustom, numIter: Int = 0) -> [Double] {
        if numIter == matrix.rows - 1 {
            return reverse(matrixAfterGaussMethod: matrix)
        }
        
        let matrixToEdit = matrix.copy()
        
        var divider = matrixToEdit[numIter, numIter]

        if divider == 0 {
            /// Make transposition
            let removedLineAndAnswer = matrixToEdit.removeRow(index: numIter)
            matrixToEdit.insertRow(row: removedLineAndAnswer.row, answer: removedLineAndAnswer.answer, in: numIter + 1)
            
            /// Get new devider
            divider = matrixToEdit[numIter, numIter]
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
        mainString += "\n    \(numIter + 1) STEP\n"
        mainString += matrixToEdit.description

        print(matrixToEdit.description)
        
        return gauss(matrix: matrixToEdit, numIter: numIter + 1)
    }
    
    
    func reverse(matrixAfterGaussMethod matrix: MatrixCustom) -> [Double] {
        
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
    
    
    func makeStep(row: [Double], nextRow: [Double], M: Double) -> [Double] {
        
        var result: [Double] = []
        
        for i in 0..<nextRow.count {
            let elementOfNextLine = nextRow[i]
            let elementOfCurrentLine = row[i]
            
            result.append((elementOfNextLine - M * elementOfCurrentLine).rounded(digits: 8))
        }
        return result
        
    }
    
    /**
    /**
     Gauss algorithm
     
     - Parameter array : Start array
     - Parameter arrayAnswers: Array with ansers
     - Parameter numIter: Parametr for recursion
     
     */
    func gauss(array: [[Double]], arrayAnswers: [Double], numIter: Int = 0) -> [Double] {
        
        /// Start revesing if all is done
        if numIter == array.count - 1 {
            return reverse(array: array, arrayAnswers: arrayAnswers)
        }
        
        
        var arrayToEdit: [[Double]] = array
        var arrayAnswersToEdit: [Double] = arrayAnswers
        
        var divider = arrayToEdit[numIter][numIter]
        
        // Maybe change to for
        if divider == 0 {
            /// Make transposition
            let lineToRemove = arrayToEdit.remove(at: numIter)
            arrayToEdit.insert(lineToRemove, at: numIter + 1)
            
            let answerToRemove = arrayAnswersToEdit.remove(at: numIter)
            arrayAnswersToEdit.insert(answerToRemove, at: numIter + 1)
            
            /// Get new devider
            divider = arrayToEdit[numIter][numIter]
        }
        
        for i in numIter + 1..<array.count {
            
            let M = arrayToEdit[i][numIter] / divider
            
            /// Remove lines and answer
            arrayToEdit.remove(at: i)
            arrayAnswersToEdit.remove(at: i)
            
            /// Insert lines and answer
            arrayToEdit.insert(makeStep(line: array[numIter], nextLine: array[i], M: M), at: i)
            arrayAnswersToEdit.insert((arrayAnswers[i] - M * arrayAnswers[numIter]).rounded(digits: 8), at: i)
        }
        
        
        for s in 0..<arrayToEdit.count {
            print("\(arrayToEdit[s]) = \(arrayAnswersToEdit[s])")
        }

        print("---")
        
        return gauss(array: arrayToEdit, arrayAnswers: arrayAnswersToEdit, numIter: numIter + 1)
    }
    
    
    /**
     Get new line from 2 lines
     
     - Parameter line: First line
     - Parameter nextLine: Second Line
     - Parameter M: M
     
     */
    func makeStep(line: [Double], nextLine: [Double], M: Double) -> [Double] {
        
        var result: [Double] = []
        
        for i in 0..<nextLine.count {
            let elementOfNextLine = nextLine[i]
            let elementOfCurrentLine = line[i]
            
            result.append((elementOfNextLine - M * elementOfCurrentLine).rounded(digits: 8))
        }
        return result
    }

    
    /**
     Reverse
     
     - Parameter array : End array
     - Parameter arrayAnswers: Array with ansers
     - Parameter M: M
     
     */
    func reverse(array: [[Double]], arrayAnswers: [Double]) -> [Double] {
        
        /// Array like [0.0, 0.0, 0.0]
        var resultArray: [Double] = Array(repeating: 0.0, count: array.count)
        
        for i in stride(from: array.count - 1, to: -1, by: -1) {
            var sum = 0.0
            for j in 0..<array.count {
                if i != j {
                    sum += array[i][j] * resultArray[j]
                }
            }
            let currentLineResult = (arrayAnswers[i] - sum) / array[i][i]
            
            resultArray.remove(at: 0)
            resultArray.insert(currentLineResult, at: i)
        }
        
        return resultArray
    }
     */
}
