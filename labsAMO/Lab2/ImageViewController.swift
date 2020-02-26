//
//  ImageViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 26.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit
import Charts

class ImageViewController: UIViewController {
    
//    var valuesSegue: [ChartDataEntry]?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var activityView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var chartButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var sliderLabel: UILabel!
    
    var sliderValue: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        activityView.isHidden = true
        activityView.layer.cornerRadius = 18
        activityView.backgroundColor = UIColor.darkText
        activityIndicator.color = .white
//        self.view.bringSubviewToFront(activityIndicator)
        
        slider.maximumValue = 60
        slider.minimumValue = 5
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        activityView.isHidden = true
        chartButton.isEnabled = true
    }
    
    @IBAction func didPressShowChart(_ sender: UIButton) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityView.isHidden = false
        self.view.bringSubviewToFront(activityView)
//        self.view.bringSubviewToFront(activityIndicator)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 , execute: {
          self.showChart()

        })
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        sliderLabel.text = "\(sliderValue)"
    }
    
    
    func showChart() {
        guard let vc = UIStoryboard(name: "Lab2", bundle: Bundle.main).instantiateViewController(withIdentifier: ChartViewController.identifier) as? ChartViewController else {
            return
        }
        
        guard let task1 = UIStoryboard(name: "Lab2", bundle: Bundle.main).instantiateViewController(withIdentifier: FirstTask2LabViewController.identifier) as? FirstTask2LabViewController else {
            return
        }
        
        vc.valuesSegue = task1.getTeorValues(count: sliderValue)
        vc.nSegue = sliderValue
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
