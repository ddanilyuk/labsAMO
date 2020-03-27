//
//  Lab3Task1ViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 17.03.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class Lab3Task1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        firstTask()
        taskTwo()
    }
    
    
    func firstTask() {
        
        let x: [Double] = [1.0, 3.0, 2.0]

        let y: [Double] = [1.0, 2.0, 5.0]

        var k = 0
        
        // кількість елементів масива
//        var n = 10
        var resArray: [Double] = []
        for i in 0..<10 {
            let result = lagrang(arrayX: x, arrayY: y, t: Double(i))
            resArray.append(result)
        }
        
        print(resArray)
    }
    
    
    func taskTwo() {
        let a: Double = 0
        let b: Double = 2
        
        let h: Double = (b - a) / 10
        
        var x: [Double] = []
        var y: [Double] = []
 
        for i in 0..<11 {
            x.append(a + (h * Double(i)))
            y.append((1 / (0.5 + pow(x[i], 2))))
        }
//        print("Function")
//        print("x", x)
//        print("y", y)
        
        var newX: [Double] = []
        var newY: [Double] = []
        
        for i in 0..<11 {
            newX.append((a + (h * Double(i)) + 0.05).rounded(digits: 5))
            newY.append((1 / (0.5 + pow(x[i], 2))).rounded(digits: 5))
        }
        
        print("Function")
        print("x", newX)
        print("y", newY)
        
        
        var lagrangeY: [Double] = []
        var lagrangeX: [Double] = []

        for i in x {
            lagrangeX.append((i + 0.05).rounded(digits: 5))
            lagrangeY.append(lagrang(arrayX: x, arrayY: y, t: i + 0.05).rounded(digits: 5))
        }
        
        print("----")
        print("Lagrange")
        print("x", lagrangeX)
        print("y", lagrangeY)
        
        var errors: [Double] = []
        for i in 0..<lagrangeY.count {
            errors.append(lagrangeY[i] - newY[i])
        }
        print("----")
        print("Errors")
        print(errors)
    }
    
    
    func lagrang(arrayX: [Double], arrayY: [Double], t: Double) -> Double {
        var z: Double = 0
        
        for j in 0..<arrayY.count {
            var p1: Double = 1
            var p2: Double = 1
            
            for i in 0..<arrayX.count {
                if i == j {
                    p1 = p1 * 1
                    p2 = p2 * 1
                } else{
                    p1 = p1 * (t - arrayX[i])
                    p2 = p2 * (arrayX[j] - arrayX[i])
                }
            }
            z = z + (arrayY[j] * (p1 / p2))
        }
            
        return z
    }

   
}
