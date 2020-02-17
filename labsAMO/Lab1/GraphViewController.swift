//
//  GraphViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
        
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage? = UIImage()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let graphImage = image {
            imageView.image = graphImage
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
