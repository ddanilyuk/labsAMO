//
//  FirstTask2LabViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 15.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class FirstTask2LabViewController: UIViewController {

    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var aDetailTextLabel: UILabel!
    
    @IBOutlet weak var timeTextLabel: UILabel!
    @IBOutlet weak var aSortedTextLabel: UILabel!
    
    var end = DispatchTime.now()
    var timeInterval = TimeInterval()
    var date = Date()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        hideKeyboard()
    }
    
    @IBAction func didPressGetResult(_ sender: UIButton) {
        let splited = (aTextField.text ?? "").split(separator: ",")
        
        var arrayA: [Double] = []
        
        for part in splited {
            let trimmed = String(part).trimmingCharacters(in: .whitespacesAndNewlines)

            arrayA.append(Double(trimmed) ?? 0.0)
        }
//        let start = DispatchTime.now()
        date = Date()
        

        let start = Date()
        aSortedTextLabel.text = "[A] = \(quicksort(arrayA).description)"
        let end = Date()   // <<<<<<<<<<   end time

//        let theAnswer = self.checkAnswer(answerNum: "\(problemNumber)", guess: myGuess)

        let timeInterval: Double = end.timeIntervalSince(start)
        
        aDetailTextLabel.text = "[A] = \(arrayA.description)"
        
        timeTextLabel.text = "Елементів: \(arrayA.count) Час: \(timeInterval)"

    }
    
    
    func quicksort<T: Comparable>(_ a: [T]) -> [T] {
        guard a.count > 1 else {
            self.end = DispatchTime.now()
//            timeInterval =
//            print(timeInterval)
            return a
        }
        

        let pivot = a[a.count/2]
        let less = a.filter { $0 < pivot }
        let equal = a.filter { $0 == pivot }
        let greater = a.filter { $0 > pivot }

        return quicksort(less) + equal + quicksort(greater)
    }
    


}
