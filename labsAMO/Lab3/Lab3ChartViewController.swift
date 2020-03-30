//
//  Lab3ChartViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 17.03.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit
import Charts

class Lab3ChartViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var chartView: LineChartView!
    @IBOutlet weak var chartViewErrors: LineChartView!
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    
    var allPointsData: (teoretical: (x: [Double], y: [Double]), test: (x: [Double], y: [Double]), error1: (x: [Double], y: [Double]), error2: (x: [Double], y: [Double]))?
    
    var aSegue: Double = 0.0
    var bSegue: Double = 2.0
    var countSegue: Int = 10
    var formula: PossibleFormuls = .myVariant

    var  isError2: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Графіки"
        
        allPointsData = getData(formula: formula, a: aSegue, b: bSegue, count: countSegue)

        setupChartView()
        setupErrorsChartView()
        setData()
        setErrorData()
    }
    
    
    @IBAction func didChangeErrorType(_ sender: UISegmentedControl) {
        
        switch segmentControll.selectedSegmentIndex {
        case 0:
            isError2 = false
            setErrorData()
        case 1:
            isError2 = true
            setErrorData()

        default:
            break
        }
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
    
    
    private func setupErrorsChartView() {
        chartViewErrors.delegate = self
        chartViewErrors.chartDescription?.enabled = true
        chartViewErrors.dragEnabled = true
        chartViewErrors.setScaleEnabled(false)
        chartViewErrors.pinchZoomEnabled = true
        
        // Y axis
        let leftAxis = chartViewErrors.leftAxis
        leftAxis.gridLineDashLengths = [5, 5]

        // X axis
        let bottomAxis = chartViewErrors.xAxis
        bottomAxis.labelPosition = .bottom
        bottomAxis.gridLineDashLengths = [10, 10]
        bottomAxis.gridLineDashPhase = 0
        
        /**
         //Minimum of y
         leftAxis.axisMinimum = -1 * abs((allPointsData?.error2.y.min() ?? 0.0) * (6 / 5))
         // Maximum of y
         leftAxis.axisMaximum = 1 * abs((allPointsData?.error2.y.max() ?? 0.0) * (6 / 5))
                 
         // Minimum of x
         bottomAxis.axisMinimum = (allPointsData?.error2.x.min() ?? 0.0)
         // Maximum of x
         bottomAxis.axisMaximum = (allPointsData?.error2.x.max() ?? 0.0) + 0.1
         */
        
        // Create marker
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartViewErrors
        marker.minimumSize = CGSize(width: 90, height: 40)
        //
        
        chartViewErrors.rightAxis.enabled = false
        chartViewErrors.legend.form = .square
        chartViewErrors.legend.font = NSUIFont(name: "Helvetica", size: 15) ?? NSUIFont()

        chartViewErrors.animate(xAxisDuration: 2)
        chartViewErrors.marker = marker
    }
    
    
    private func setData() {
        var teoreticalValues: [ChartDataEntry] = []
        var testValues: [ChartDataEntry] = []
        
        guard let allPointsData = allPointsData else { return }
        for i in 0..<allPointsData.teoretical.x.count {
            teoreticalValues.append(ChartDataEntry(x: allPointsData.teoretical.x[i], y: allPointsData.teoretical.y[i]))
        }
        
        for i in 0..<allPointsData.test.x.count {
            testValues.append(ChartDataEntry(x: allPointsData.test.x[i], y: allPointsData.test.y[i]))
        }

        let teoreticalLine = LineChartDataSet(entries: teoreticalValues, label: "Теоретичні")
        
        teoreticalLine.setColor(.blue)
        teoreticalLine.setCircleColor(.gray)
        teoreticalLine.lineWidth = 1.5
        teoreticalLine.circleRadius = 0
        teoreticalLine.valueFont = .systemFont(ofSize: 10)
        teoreticalLine.formLineDashLengths = [5, 5]
        teoreticalLine.formLineWidth = 6
        
        teoreticalLine.drawCirclesEnabled = false
        teoreticalLine.drawValuesEnabled = false
        teoreticalLine.drawIconsEnabled = false
        teoreticalLine.drawCircleHoleEnabled = false

        
        let testLine = LineChartDataSet(entries: testValues, label: "Інтерпольовані")
    
        testLine.setColor(.black)
        testLine.setCircleColor(.gray)
        testLine.lineWidth = 1.5
        testLine.circleRadius = 3
        testLine.valueFont = .systemFont(ofSize: 10)
        testLine.formLineDashLengths = [5, 5]
        testLine.formLineWidth = 6
        
        testLine.drawIconsEnabled = false
        testLine.drawCircleHoleEnabled = false
        testLine.drawCirclesEnabled = false
        testLine.drawValuesEnabled = false
        
        
        // Setting this lines to data
        let dataChart = LineChartData(dataSets: [testLine, teoreticalLine])
        chartView.data = dataChart
    }
    
    
    func setErrorData() {
        guard let allPointsData = allPointsData else { return }
        
        var errorValues: [ChartDataEntry] = []
        
        if !isError2 {
            for i in 0..<allPointsData.error2.x.count {
                let yPoint = -1 * log10(abs(allPointsData.error2.y[i]))
                if yPoint.isFinite && !yPoint.isNaN {
                    print(yPoint)

                    errorValues.append(ChartDataEntry(x: allPointsData.error2.x[i], y: yPoint))
                }
            }
        } else {
            for i in 0..<allPointsData.error1.x.count {
                let yPoint = allPointsData.error1.y[i]
                if yPoint.isFinite && !yPoint.isNaN {
                    errorValues.append(ChartDataEntry(x: allPointsData.error1.x[i], y: yPoint))
                }
            }
        }
        let errorLineLabel = isError2 ? "Похибка інтерполяції" : "Оцінка похибки (Δn)"
        
        let errorLine = LineChartDataSet(entries: errorValues, label: errorLineLabel)
    
        errorLine.setColor(.red)
        errorLine.setCircleColor(.gray)
        errorLine.lineWidth = 1.5
        errorLine.circleRadius = 0
        errorLine.valueFont = .systemFont(ofSize: 10)
        errorLine.formLineDashLengths = [5, 5]
        errorLine.formLineWidth = 6
        errorLine.mode = .linear
        
        errorLine.drawCirclesEnabled = false
        errorLine.drawValuesEnabled = false
        errorLine.drawIconsEnabled = false
        errorLine.drawCircleHoleEnabled = false

        
        // Setting this line to data
        let dataChart = LineChartData(dataSets: [errorLine])
        chartViewErrors.data = dataChart
    }
}
