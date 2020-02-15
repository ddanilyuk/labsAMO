//
//  CustomNavigationController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
//        let navBarbutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: nil)
//        navItem.leftBarButtonItem = navBarbutton
    }
    

    /*
    // MARK: - Navigation
     
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
//        self.navigationController?.navigationItem.rightBarButtonItem = add
//        segue.destination.navigationController?.navigationItem.rightBarButtonItem = add

    }

}
