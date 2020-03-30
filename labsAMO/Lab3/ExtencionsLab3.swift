//
//  ExtencionsLab3.swift
//  labsAMO
//
//  Created by Денис Данилюк on 29.03.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func getFormulaData(formula: PossibleFormuls, a: Double, b: Double, count: Int = 10) -> (x: [Double], y: [Double]) {
        let h: Double = (b - a) / Double(count)
       
        var x: [Double] = []
        var y: [Double] = []

        for i in 0...count {
            x.append(a + (h * Double(i)))
            switch formula {
                
            case .myVariant:
                y.append((1 / (0.5 + pow(x[i], 2))))
            case .sinx:
                y.append(sin(x[i]))
            }
        }
        
        return (x, y)
    }
    
    
    func lagrang(arrayX: [Double], arrayY: [Double], t: Double) -> Double {
        var z: Double = 0
        
        for j in 0..<arrayY.count {
            var p1: Double = 1
            var p2: Double = 1
            
            for i in 0..<arrayX.count {
                if i != j {
                    p1 = p1 * (t - arrayX[i])
                    p2 = p2 * (arrayX[j] - arrayX[i])
                }
            }
            z = z + (arrayY[j] * (p1 / p2))
        }
            
        return z
    }
    
    
    func getInternolatedArray(formula: PossibleFormuls, a: Double, b: Double, countOfInterpolation: Int, countOfArray: Int) -> (x: [Double], y: [Double]) {
        
        let (xTeoretical, yTeoretical) = getFormulaData(formula: formula, a: a, b: b, count: countOfInterpolation)
        
        let xTest = getFormulaData(formula: formula, a: a, b: b, count: countOfArray).x
        
        var yResult: [Double] = []
        
        for x in xTest {
            yResult.append(lagrang(arrayX: xTeoretical, arrayY: yTeoretical, t: x))
        }

        return (x: xTest, y: yResult)
    }
    
    
    func getInternolatedYPoint(formula: PossibleFormuls, a: Double, b: Double, countOfInterpolation: Int, x: Double) -> Double {
        
        let (xTeoretical, yTeoretical) = getFormulaData(formula: formula, a: a, b: b, count: countOfInterpolation)

        let y = lagrang(arrayX: xTeoretical, arrayY: yTeoretical, t: x)
        
        return y
    }
    
    
    func getData(formula: PossibleFormuls, a: Double, b: Double, count: Int) ->
                    (teoretical: (x: [Double], y: [Double]),
                    test: (x: [Double], y: [Double]),
                    error1: (x: [Double], y: [Double]),
                    error2: (x: [Double], y: [Double])) {
                                        
                    
        let (xTeoretical, yTeoretical) = getFormulaData(formula: formula, a: a, b: b, count: 1000)
        
        let (xTestLagrange, yTestLagrange) = getInternolatedArray(formula: formula, a: a, b: b, countOfInterpolation: count, countOfArray: 1000)
        
        let yTestLagrangeP1 = getInternolatedArray(formula: formula, a: a, b: b, countOfInterpolation: count + 1, countOfArray: 1000).y

        /// Error between normal value and `count` interpolation
        var yErrors1: [Double] = []
        for i in 0..<yTestLagrange.count {
            yErrors1.append((yTeoretical[i] - yTestLagrange[i]).rounded(digits: 12))
        }
        
        /// Error between `count` interpolation and `count + 1` interpolation
        var yErrors2: [Double] = []
        for i in 0..<yTestLagrangeP1.count {
//            yErrors2.append(-1 * log10((yTestLagrange[i] - yTestLagrangeP1[i])).rounded(digits: 8))
            yErrors2.append((yTestLagrange[i] - yTestLagrangeP1[i]))

        }
              
                 
        let teoretical: (x: [Double], y: [Double]) = (xTeoretical, yTeoretical)
                        
        let test: (x: [Double], y: [Double]) = (xTestLagrange, yTestLagrange)
                        
        let error1: (x: [Double], y: [Double]) = (xTestLagrange, yErrors1)
                        
        let error2: (x: [Double], y: [Double]) = (xTestLagrange, yErrors2)

        return (teoretical, test, error1, error2)
    }

}
