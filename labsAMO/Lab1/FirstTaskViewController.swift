//
//  FirstTaskViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class FirstTaskViewController: UIViewController {
    
    @IBOutlet weak var aTextField: UITextField!
    @IBOutlet weak var cTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        setupButton()
    }
    
    
    @IBAction func didPressResultButton(_ sender: UIButton) {
        resultLabel.text = "Y1 = \(calculate(a: aTextField.text ?? "", c: cTextField.text ?? ""))"
    }
    
    @IBAction func didPressFile(_ sender: UIButton) {
        var array: [String] = []

        do {
            let text2 = try makeWritableCopy(named: "main.txt", ofResourceFile: "main.txt")
            let array = text2.components(separatedBy: ", ")

            aTextField.text = array[0].trimmingCharacters(in: .whitespacesAndNewlines)
            cTextField.text = array[1].trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            
        }
        
    }
    
    func makeWritableCopy(named destFileName: String, ofResourceFile originalFileName: String) throws -> String {
        // Get Documents directory in app bundle
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("No document directory found in application bundle.")
        }

        // Get URL for dest file (in Documents directory)
        let writableFileURL = documentsDirectory.appendingPathComponent(destFileName)

        // If dest file doesn’t exist yet
        if (try? writableFileURL.checkResourceIsReachable()) == nil {
            // Get original (unwritable) file’s URL
            guard let originalFileURL = Bundle.main.url(forResource: originalFileName, withExtension: nil) else {
                fatalError("Cannot find original file “\(originalFileName)” in application bundle’s resources.")
            }

            // Get original file’s contents
            let originalContents = try Data(contentsOf: originalFileURL)

            // Write original file’s contents to dest file
            try originalContents.write(to: writableFileURL, options: .atomic)
            print("Made a writable copy of file “\(originalFileName)” in “\(documentsDirectory)\\\(destFileName)”.")

        } else { // Dest file already exists
            // Print dest file contents
            return try String(contentsOf: writableFileURL, encoding: String.Encoding.utf8)
//            print("File “\(destFileName)” already exists in “\(documentsDirectory)”.\nContents:\n\(contents)")
        }
        
        return ""

    }
    
    func calculate(a: String, c: String) -> String {
        guard let doubleA = Double(a), let doubleC = Double(c) else { return "Числа введені не корректно" }

        if (doubleA - doubleC) < 0 {
            let alert = UIAlertController(title: nil, message: "Факторіал з мінусом!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Змінити значення", style: .default, handler: { (_) in
            }))
            
            self.present(alert, animated: true, completion: {
            })
            
            return "РЕЗУЛЬТАТ"
        }
        
        let part1 = ((pow(doubleA, 2) - pow(doubleC, 2)) / 7)
        let part2 = (factorial(doubleA) / (factorial(doubleC) * factorial(doubleA - doubleC)))
        let result = part1 + part2
                
        return String(result.rounded(digits: 3))
    }
    
    
    @IBAction func showGraphButton(_ sender: UIBarButtonItem) {
        
        guard let graphVC : GraphViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: GraphViewController.identifier) as? GraphViewController else { return }
        graphVC.image = UIImage(named: "lab1Graph1")
        
        present(graphVC, animated: true, completion: nil)
    }
    
    
    func factorial(_ n: Double) -> Double {
        if n == 0 {
            return 1
        }
        return n * factorial(n-1)
    }
    

}
