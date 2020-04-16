//
//  Lab4ChartViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 09.04.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit
import Charts

class Lab4ChartViewController: UIViewController, ChartViewDelegate {
    
    var aSegue: Double?
    var bSegue: Double?
    
    @IBOutlet weak var chartView: LineChartView!
    
    @IBOutlet weak var chartSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChartView()
        setData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeChart(_ sender: UISegmentedControl) {
        setData()
    }
    
    private func setupChartView() {
        chartView.delegate = self
        chartView.chartDescription?.enabled = true
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // Y axis
        let leftAxis = chartView.leftAxis
        leftAxis.gridLineDashLengths = [5, 5]

        // X axis
        let bottomAxis = chartView.xAxis
        bottomAxis.labelPosition = .bottom
        bottomAxis.gridLineDashLengths = [10, 10]
        bottomAxis.gridLineDashPhase = 0
        
        /**
         //Minimum of y
         leftAxis.axisMinimum = (allPointsData?.teoretical.y.min() ?? 0.0) * (6/5)
         // Maximum of y
         leftAxis.axisMaximum = (allPointsData?.teoretical.y.max() ?? 0.0) * (6/5)

         // Minimum of x
         bottomAxis.axisMinimum = (allPointsData?.test.x.min() ?? 0.0) * (6/5)
         // Maximum of x
         bottomAxis.axisMaximum = (allPointsData?.test.x.max() ?? 0.0) * (6/5)
         */
        
        // Create marker
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 90, height: 40)
        //
        
        chartView.rightAxis.enabled = false
        chartView.legend.form = .square
        chartView.legend.font = NSUIFont(name: "Helvetica", size: 15) ?? NSUIFont()
        chartView.animate(xAxisDuration: 2)
        chartView.marker = marker
    }

    
    private func setData() {
        var fValues: [ChartDataEntry] = []
        var fDValues: [ChartDataEntry] = []
        var fDDValues: [ChartDataEntry] = []
        guard let a = aSegue, let b = bSegue else { return }
        var values: [ChartDataEntry] = []
        var nameLine = String()

        switch chartSegmentControl.selectedSegmentIndex {
        case 0:
            nameLine = "f(x)"
            for x in stride(from: a, to: b, by: 0.005) {
                let y = myFunction(x: x)
                fValues.append(ChartDataEntry(x: x, y: y))
            }
            values = fValues
        case 1:
            nameLine = "f`(x)"
            for x in stride(from: a, to: b, by: 0.005) {
                let y = myDFunction(x: x)
                fDValues.append(ChartDataEntry(x: x, y: y))
            }
            values = fDValues
        case 2:
            nameLine = "f``(x)"
            for x in stride(from: a, to: b, by: 0.005) {
                let y = myDDFunction(x: x)
                fDDValues.append(ChartDataEntry(x: x, y: y))
            }
            values = fDDValues

        default:
            break
        }

        let line = LineChartDataSet(entries: values, label: nameLine)
        
        line.setColor(.red)
        line.setColor(#colorLiteral(red: 0, green: 0.4492976665, blue: 0.5591170788, alpha: 1))
        line.setCircleColor(.gray)
        line.lineWidth = 1.5
        line.circleRadius = 0
        line.valueFont = .systemFont(ofSize: 10)
        line.formLineDashLengths = [5, 5]
        line.formLineWidth = 6
        line.mode = .linear
        
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false
        line.drawIconsEnabled = false
        line.drawCircleHoleEnabled = false
        
        
        if chartSegmentControl.selectedSegmentIndex == 0 {
            let circle = LineChartDataSet(entries: [ChartDataEntry(x: try! getResult(a: 4.5, b: 4.5 + 0.499, epsilon: 0.0001, function: myFunction, dFunction: myDFunction, ddFunction: myDDFunction), y: 0)], label: "")
                
                circle.setCircleColor(.black)
                circle.setColor(.clear)
            
                circle.circleRadius = 3
                circle.drawCirclesEnabled = true
                circle.drawValuesEnabled = false
            chartView.data = LineChartData(dataSets: [line, circle])
        } else {
            chartView.data = LineChartData(dataSets: [line])
        }
    }

}
