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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var activityView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var chartButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var sliderLabel: UILabel!
    
    var sliderValue: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupActivityIndicator()
        
        setupSlider()
    }
    
    
    private func setupSlider() {
        slider.maximumValue = 90
        slider.minimumValue = 5
    }
    
    
    private func setupActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        activityIndicator.color = .white
        
        activityView.isHidden = true
        activityView.layer.cornerRadius = 18
        activityView.backgroundColor = UIColor.darkText
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        activityView.isHidden = true
        chartButton.isEnabled = true
    }
    
    
    @IBAction func didPressShowChart(_ sender: UIButton) {
        // Stop activity indicator
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityView.isHidden = false
        self.view.bringSubviewToFront(activityView)
        
        // Getting test result and showing charts
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 , execute: {
          self.showChart()
        })
    }
    
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        sliderLabel.text = "\(sliderValue)"
    }
    
    
    func showChart() {
        guard let chartVC = UIStoryboard(name: "Lab2", bundle: Bundle.main).instantiateViewController(withIdentifier: ChartViewController.identifier) as? ChartViewController else { return }
        
        guard let firstTaskLab2VC = UIStoryboard(name: "Lab2", bundle: Bundle.main).instantiateViewController(withIdentifier: FirstTask2LabViewController.identifier) as? FirstTask2LabViewController else { return }
        
        DispatchQueue.main.async {
            
            chartVC.valuesSegue = firstTaskLab2VC.getTestValues(count: self.sliderValue)
            chartVC.nSegue = self.sliderValue
            
            self.navigationController?.pushViewController(chartVC, animated: true)
        }
    }
    
}
