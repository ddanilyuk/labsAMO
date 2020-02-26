//
//  FirstTask2LabViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 15.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit
import Charts

class FirstTask2LabViewController: UIViewController {

    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var detailTextLabel: UILabel!
    
    @IBOutlet weak var leftDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var sortedTextLabel: UILabel!
    
    var end = DispatchTime.now()
    var timeInterval = TimeInterval()
    var date = Date()

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        hideKeyboard()
        
    }
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            leftDescriptionLabel.text = "[A]:   "
            mainTextField.placeholder = "Введіть [A]"
        case 1:
            leftDescriptionLabel.text = "n:   "
            mainTextField.placeholder = "Введіть кількість елементів массиву"
        default:
            return
        }
    }
    @IBAction func didPressShowChart(_ sender: UIBarButtonItem) {
        
        
    }
    @IBAction func didPressShowCrats(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Lab2", bundle: Bundle.main).instantiateViewController(withIdentifier: ImageViewController.identifier) as? ImageViewController else {
            return
        }
        
//        vc.valuesSegue = getTeorValues()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        let startDoArray = Date()

        var arrayA: [Double] = []
        
        if segmentControl?.selectedSegmentIndex == 0 {
            
            let splited = (mainTextField.text ?? "").split(separator: ",")
            for part in splited {
                let trimmed = String(part).trimmingCharacters(in: .whitespacesAndNewlines)

                arrayA.append(Double(trimmed) ?? 0.0)
            }
        } else {
            let n = Int((mainTextField.text ?? "")) ?? 0
            for _ in 0..<n {
                arrayA.append((Double.random(in: 0..<1000).rounded(digits: 2)))
            }
        }
        
        let endDoArray = Date()
        let timeIntervalDoArray: Double = endDoArray.timeIntervalSince(startDoArray)
        print(timeIntervalDoArray)

        let start = Date()
        sortedTextLabel.text = "Відстортований [A] = \(quicksort(arrayA).description)"
        detailTextLabel.text = "Початковий [A] = \(arrayA.description)"
        let end = Date()   // <<<<<<<<<<   end time
        let timeInterval: Double = end.timeIntervalSince(start)

        timeTextLabel.text = "Елементів: \(arrayA.count) Час: \(timeInterval.rounded(digits: 8))"
        

//        let quicksort_timed = timeit(closure: quicksort)
//        let res = quicksort_timed(arrayA)
//        sortedTextLabel.text = "[A] = \(res.0.description)"
//        detailTextLabel.text = "[A] = my\(arrayA.description)"
//        timeTextLabel.text = "Елементів: \(arrayA.count) Час: \(res.1.rounded(digits: 4))"
//        print("**********************")
//        print("My \(timeInterval)")
//        print("Danil \((res.1))")
//        print("Difference between my and Danil \(timeInterval - (res.1))")


    }
    
    func getTeorValues(count: Int) -> [ChartDataEntry] {
        var values: [ChartDataEntry] = []
//        var result: [(n: Double, time: Double)] = []
//        for n in 1..<1000 {
//            let startDoArray = Date()
//
//            var arrayA: [Double] = []
//            var sorterd: [Double] = []
//
//            for _ in 0..<n {
//                arrayA.append((Double.random(in: 0..<100).rounded(digits: 2)))
//            }
//
//            let endDoArray = Date()
//            let timeIntervalDoArray: Double = endDoArray.timeIntervalSince(startDoArray)
//
//            let start = Date()
//            sorterd = quicksort(arrayA)
//            let end = Date()
//
//            let timeInterval: Double = end.timeIntervalSince(start)
//
//            let time = timeInterval - timeIntervalDoArray
//
//            let charData = ChartDataEntry(x: Double(n), y: time * 1000000)
//            print(Double(n))
//            print(time)
//            values.append(charData)
//        }
        for n in 1..<count {
            let nn = n * 1000
            let startDoArray = Date()

            var arrayA: [Double] = []
            var sorterd: [Double] = []
            
            for _ in 0..<nn {
                arrayA.append((Double.random(in: 0..<100).rounded(digits: 2)))
            }
            
            let endDoArray = Date()
            let timeIntervalDoArray: Double = endDoArray.timeIntervalSince(startDoArray)

            let start = Date()
            sorterd = quicksort(arrayA)
//            sorterd = buble(array: arrayA)
            let end = Date()
            
            let timeInterval: Double = end.timeIntervalSince(start)
            
            let time = timeInterval - timeIntervalDoArray
            
            let charData = ChartDataEntry(x: Double(nn), y: time * 1000)

            values.append(charData)
        }
        return values
    }
    
    func getTeorValues2() -> [ChartDataEntry] {
            var values: [ChartDataEntry] = []
//            for n in 1..<1000 {
//                let startDoArray = Date()
//
//                var arrayA: [Double] = []
//                var sorterd: [Double] = []
//
//                for _ in 0..<n {
//                    arrayA.append((Double.random(in: 0..<100).rounded(digits: 2)))
//                }
//
//                let endDoArray = Date()
//                let timeIntervalDoArray: Double = endDoArray.timeIntervalSince(startDoArray)
//
//                let quicksort_timed = timeit(closure: quicksort)
//
//                let res = quicksort_timed(arrayA)
//
//
//                let time = res.1.rounded(digits: 8) - timeIntervalDoArray
//
//                let charData = ChartDataEntry(x: Double(n), y: time * 1000000)
//
//                values.append(charData)
//            }
            for n in 1..<51 {
                let nn = n * 1000
                let startDoArray = Date()

                var arrayA: [Double] = []
                var sorterd: [Double] = []
                
                for _ in 0..<nn {
                    arrayA.append((Double.random(in: 0..<100).rounded(digits: 2)))
                }
                
                let endDoArray = Date()
                let timeIntervalDoArray: Double = endDoArray.timeIntervalSince(startDoArray)

                let quicksort_timed = timeit(closure: quicksort)
                
                let res = quicksort_timed(arrayA)
                        
                        
                let time = res.1.rounded(digits: 8) - timeIntervalDoArray
                
                let charData = ChartDataEntry(x: Double(nn), y: time * 1000)

                values.append(charData)
            }
            return values
        }
    
    typealias FuncType = ([Double]) -> ([Double], TimeInterval)
    
    func timeit(closure: @escaping ([Double]) -> [Double]) -> (FuncType) {
        func wrap(args: [Double]) -> ([Double], TimeInterval) {
            let start = Date()
            let res = closure(args)
            let end = Date()
            let timeInterval: Double = end.timeIntervalSince(start)

            return (res, timeInterval)
        }
        
        return wrap
    }
    
    func quicksort<T: Comparable>(_ a: [T]) -> [T] {
        guard a.count > 1 else {
            self.end = DispatchTime.now()
            return a
        }
        

        let pivot = a[a.count/2]
        let less = a.filter { $0 < pivot }
        let equal = a.filter { $0 == pivot }
        let greater = a.filter { $0 > pivot }

        return quicksort(less) + equal + quicksort(greater)
    }
    
    
    func buble(array: [Double]) -> [Double]{
        var arrayReturn = array
        for i in 0..<arrayReturn.count {
          for j in 1..<arrayReturn.count - i {
            if arrayReturn[j] < arrayReturn[j-1] {
              let tmp = arrayReturn[j-1]
              arrayReturn[j-1] = arrayReturn[j]
              arrayReturn[j] = tmp
            }
          }
        }
        return arrayReturn
    }
}
