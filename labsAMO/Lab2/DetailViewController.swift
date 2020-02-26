//
//  DetailViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 26.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var text: String?

    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let text = text {
            textView.text = text
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
