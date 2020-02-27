//
//  WriteViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 27.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    var myData: Data?

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
        

    }
    
    
    @IBAction func didPressWrite(_ sender: UIButton) {
        let text = textField.text ?? ""

        // Write **text** to file
        do {
            let stuffFileURL = try makeWritableCopy(named: "main.txt", ofResourceFile: "main.txt")
            try text.write(to: stuffFileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            
        }
        self.navigationController?.popViewController(animated: true)
    }

    
    func makeWritableCopy(named destFileName: String, ofResourceFile originalFileName: String) throws -> URL {
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
            let contents = try String(contentsOf: writableFileURL, encoding: String.Encoding.utf8)
            print("File “\(destFileName)” already exists in “\(documentsDirectory)”.\nContents:\n\(contents)")
        }

        // Return dest file URL
        return writableFileURL
    }

}
