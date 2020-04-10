//
//  Lab5ViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 10.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class Lab5ViewController: UIViewController {
    
    let array: [[Double]] = [[7.09, 1.17, -2.23],
                             [0.43, 1.40, -0.62],
                             [3.21, -4.25, 2.13]]

    let arrayAnswers: [Double] = [-4.75, -1.05, -5.06]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        hideKeyboard()
        
        let result = gauss(array: array, arrayAnswers: arrayAnswers)
        for i in 0..<result.count {
            print("x\(i+1) = \(result[i])")
        }
    }
    


    func gauss(array: [[Double]], arrayAnswers: [Double], numIter: Int = 0) -> [Double] {
        
        if numIter == array.count - 1 {
            return reverse(array: array, arrayAnswers: arrayAnswers)
        }
        
        let toDelete = array[numIter][numIter]
        
        
        var sum: [[Double]] = array
        var answer: [Double] = arrayAnswers
        
        for _ in 0..<array.count - numIter - 1 {
            sum.removeLast()
            answer.removeLast()
        }
        
        
        for i in numIter + 1..<array.count {
            
            let M = array[i][numIter] / toDelete
            
            sum.append(makeStep(line: array[numIter], nextLine: array[i], M: M))
            answer.append((arrayAnswers[i] - M * arrayAnswers[numIter]).rounded(digits: 8))
        }
//
//        for s in 0..<sum.count {
//            print("\(sum[s]) = \(answer[s])")
//        }
        
//        print("---")
        
        return gauss(array: sum, arrayAnswers: answer, numIter: numIter + 1)
    }

    
    func makeStep(line: [Double], nextLine: [Double], M: Double) -> [Double] {
        
        var result: [Double] = []
        
        for i in 0..<nextLine.count {
            let elementOfNextLine = nextLine[i]
            let elementOfCurrentLine = line[i]
            
            result.append((elementOfNextLine - M * elementOfCurrentLine).rounded(digits: 8))
        }
        return result
    }

    
    func reverse(array: [[Double]], arrayAnswers: [Double]) -> [Double] {
        var result: [Double] = Array(repeating: 0.0, count: array.count)
        
        
        for i in stride(from: array.count - 1, to: -1, by: -1) {
            
            var sum = 0.0
            for j in 0..<array.count {
                if i != j {
                    sum += array[i][j] * result[j]
                }
            }
            
            let some = (arrayAnswers[i] - sum) / array[i][i]
            
            result.remove(at: 0)
            result.insert(some, at: i)
        }
//        print(result)
        return result
    }
}
