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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Графіки"
        
        setupChartView()
        setupErrorsChartView()
        setData()
        setErrorData()
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
        
        // Data to set maximum and minimum of X and Y
        let pointsData = getData()
        // Minimum of y
        leftAxis.axisMinimum = pointsData.teoretical.y.min() ?? 0.0
        // Maximum of y
        leftAxis.axisMaximum = (pointsData.teoretical.y.max() ?? 0.0) + 0.1
                
        // Minimum of x
        bottomAxis.axisMinimum = pointsData.test.x.min() ?? 0.0
        // Maximum of x
        bottomAxis.axisMaximum = (pointsData.test.x.max() ?? 0.0) + 0.1
        
        // Create marker
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartView
        marker.minimumSize = CGSize(width: 90, height: 40)
        //
        
        chartView.rightAxis.enabled = false
        chartView.legend.form = .line
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
        
        // Data to set maximum and minimum of X and Y
        let pointsData = getData()
        // Minimum of y
        leftAxis.axisMinimum = -1 * abs((pointsData.error.y.min() ?? 0.0) * (6 / 5))
        // Maximum of y
        leftAxis.axisMaximum = 1 * abs((pointsData.error.y.max() ?? 0.0) * (6 / 5))
                
        // Minimum of x
        bottomAxis.axisMinimum = (pointsData.error.x.min() ?? 0.0)
        // Maximum of x
        bottomAxis.axisMaximum = (pointsData.error.x.max() ?? 0.0) + 0.1
        
        // Create marker
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartViewErrors
        marker.minimumSize = CGSize(width: 90, height: 40)
        //
        
        chartViewErrors.rightAxis.enabled = false
        chartViewErrors.legend.form = .line
        chartViewErrors.animate(xAxisDuration: 2)
        chartViewErrors.marker = marker
    }
    
    
    private func getFormulaData(accuracy: Int = 10, a: Double = 0, b: Double = 5) -> (x: [Double], y: [Double]) {
        let h: Double = (b - a) / Double(accuracy)
       
        var x: [Double] = []
        var y: [Double] = []

        for i in 0...accuracy {
            x.append(a + (h * Double(i)))
//            y.append((1 / (0.5 + pow(x[i], 2))))
            y.append(exp(sin(x[i])))
        }
        
        return (x, y)
    }

    
    private func getData() -> (teoretical: (x: [Double], y: [Double]),
                               test: (x: [Double], y: [Double]),
                               error: (x: [Double], y: [Double])) {
            
        let (xWithTenPoints, yWithTenPoints) = getFormulaData(accuracy: 10)
        
        let (xTeoretical, yTeoretical) = getFormulaData(accuracy: 1000)
        
        var yTestLagrange: [Double] = []
        for i in xTeoretical {
            yTestLagrange.append(lagrang(arrayX: xWithTenPoints, arrayY: yWithTenPoints, t: i).rounded(digits: 5))
        }
        
        var yErrors: [Double] = []
        for i in 0..<yTestLagrange.count {
            yErrors.append((yTeoretical[i] - yTestLagrange[i]).rounded(digits: 8))
        }
//        print(yErrors)
                                
        let teoretical: (x: [Double], y: [Double]) = (xTeoretical, yTeoretical)
        let test: (x: [Double], y: [Double]) = (xTeoretical, yTestLagrange)
        let error: (x: [Double], y: [Double]) = (xTeoretical, yErrors)
        
        return (teoretical, test, error)
    }
    
    
    private func setData() {
        let pointsData = getData()
        
        var teoreticalValues: [ChartDataEntry] = []
        var testValues: [ChartDataEntry] = []
        
        for i in 0..<pointsData.teoretical.x.count {
            teoreticalValues.append(ChartDataEntry(x: pointsData.teoretical.x[i], y: pointsData.teoretical.y[i]))
        }
        
        for i in 0..<pointsData.test.x.count {
            testValues.append(ChartDataEntry(x: pointsData.test.x[i], y: pointsData.test.y[i]))
        }

        let teoreticalLine = LineChartDataSet(entries: teoreticalValues, label: "Теоретично")
        
        teoreticalLine.setColor(.blue)
        teoreticalLine.setCircleColor(.gray)
        teoreticalLine.lineWidth = 3
        teoreticalLine.circleRadius = 0
        teoreticalLine.valueFont = .systemFont(ofSize: 10)
        teoreticalLine.formLineDashLengths = [5, 5]
        teoreticalLine.formLineWidth = 6
        
        teoreticalLine.drawCirclesEnabled = false
        teoreticalLine.drawValuesEnabled = false
        teoreticalLine.drawIconsEnabled = false
        teoreticalLine.drawCircleHoleEnabled = false

        
        let testLine = LineChartDataSet(entries: testValues, label: "Практично")
    
        testLine.setColor(.black)
        testLine.setCircleColor(.gray)
        testLine.lineWidth = 3
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
        let pointsData = getData()
                
        var errorValues: [ChartDataEntry] = []
        for i in 0..<pointsData.error.x.count {
            errorValues.append(ChartDataEntry(x: pointsData.error.x[i], y: pointsData.error.y[i]))
        }
        
        let errorLine = LineChartDataSet(entries: errorValues, label: "Помилка")
    
        errorLine.setColor(.red)
        errorLine.setCircleColor(.gray)
        errorLine.lineWidth = 3
        errorLine.circleRadius = 0
        errorLine.valueFont = .systemFont(ofSize: 10)
        errorLine.formLineDashLengths = [5, 5]
        errorLine.formLineWidth = 6
        errorLine.mode = .cubicBezier
        
        errorLine.drawCirclesEnabled = false
        errorLine.drawValuesEnabled = false
        errorLine.drawIconsEnabled = false
        errorLine.drawCircleHoleEnabled = false

        
        // Setting this line to data
        let dataChart = LineChartData(dataSets: [errorLine])
        chartViewErrors.data = dataChart
    }
    
    
    func lagrang(arrayX: [Double], arrayY: [Double], t: Double) -> Double {
        var z: Double = 0
        
        for j in 0..<arrayY.count {
            var p1: Double = 1
            var p2: Double = 1
            
            for i in 0..<arrayX.count {
                if i != j {
                    p1 = p1 * (t - arrayX[i])
                    p2 = p2 * (arrayX[j] - arrayX[i])
                }
            }
            z = z + (arrayY[j] * (p1 / p2))
        }
            
        return z
    }
    
//    private func aitken(arrayX: [Double], arrayY: [Double]) {
//        let n = arrayX.count
//
//    }
//    public static double[] aitken(double[] x, double[] y) {
//      int n = x.length;
//      double[] dividedDifferences = y.clone();
//      for(int i=1; i<n; i++) {
//        for(int j=n-1; j>0; j--) {
//          if(j-i>=0) {
//            dividedDifferences[j] = (dividedDifferences[j]-dividedDifferences[j-1])/(x[j]-x[j-i]);
//          }
//        }
//      }
//      return dividedDifferences;
//    }
}
