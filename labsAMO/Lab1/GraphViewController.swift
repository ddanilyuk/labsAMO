//
//  GraphViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 14.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, UIScrollViewDelegate {
        
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image: UIImage? = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        if let graphImage = image {
            imageView.image = graphImage
        }
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
