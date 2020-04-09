//
//  Lab4+Extensions.swift
//  labsAMO
//
//  Created by Денис Данилюк on 09.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

extension UIViewController {
    func getResult(a: Double, b: Double, epsilon: Double, function: (Double) -> Double, dFunction: (Double) -> Double, ddFunction: (Double) -> Double) throws -> Double {
                
        if function(a) * function(b) > 0 {
            throw ResultError.noRoots
        } else if dFunction(a).sign != dFunction(b).sign || ddFunction(a).sign != ddFunction(b).sign {
            throw ResultError.functionIsNotHomogeneous
        } else {
            var temp = 0.0
                
            if abs(b - a) < epsilon {
                return (a + b) / 2
            }
            
            if function(b) * ddFunction(b) >= 0 {
                print("x0 = b")
                temp = b
            } else {
                print("x0 = a")
                temp = a
            }
            
            do {
                return try newtons_method2(f: function, dF: dFunction, x0: temp, epsilon: epsilon)
            } catch ResultError.divisionByZero {
                throw ResultError.divisionByZero
            } catch ResultError.iterationLimit {
                throw ResultError.iterationLimit
            } catch {
                throw error
            }
        }
    }
    
    
    func newtons_method2(f: (Double) -> Double, dF: (Double) -> Double, x0: Double, epsilon: Double, maxIter: Int = 99999) throws -> Double {
        var xn = x0
        for n in 0..<maxIter {
            let fxn = f(xn)
            if abs(fxn) < epsilon {
                print("Found solution after", n, "iterations.")
                return xn
            }
            
            let dFxn = dF(xn)
            if dFxn == 0 {
                print("Zero derivative. No solution found.")
                throw ResultError.divisionByZero
            }
            xn = xn - (fxn / dFxn)
        }
        print("Exceeded maximum iterations. No solution found.")
        throw ResultError.iterationLimit
    }
        
    // MY
    func myFunction(x: Double) -> Double {
        return 10 * atan(5 - x) - 1
    }

    func myDFunction(x: Double) -> Double {
        return -10 / ((pow((x - 5), 2)) + 1)
    }

    func myDDFunction(x: Double) -> Double {
        return (20 * (x - 5)) / pow(pow((x - 5), 2) + 1, 2)
    }
}
