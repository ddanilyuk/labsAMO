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
        
    }

}
