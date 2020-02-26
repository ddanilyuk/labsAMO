//
//  ChartViewController.swift
//  labsAMO
//
//  Created by Денис Данилюк on 24.02.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet var chartView: LineChartView!
    
    var valuesSegue: [ChartDataEntry]?
    var nSegue: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Графіки"

        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()

        leftAxis.axisMaximum = 700
        leftAxis.axisMinimum = -50
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        
        chartView.animate(xAxisDuration: 2.5)
        guard let count = nSegue else { return }
        self.setDataCount(n: count)
    }

    func setDataCount(n: Int) {

        var values: [ChartDataEntry] = []
        
        for i in 1..<n {
            let ii = i * 1000
            let x = Double(ii)
            let y = (Double(ii) * log(Double(ii))) / 1000
            
            values.append(ChartDataEntry(x: x, y: y))
        }
        
        // First line
        let set1 = LineChartDataSet(entries: values, label: "Теоретично")
        set1.drawIconsEnabled = false
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 0
        set1.drawCircleHoleEnabled = false
//        set1.formSize = 15
        
        // Second line
        guard let value2 = valuesSegue else { return }
        let set2 = LineChartDataSet(entries: value2, label: "Практичні")
        set2.drawIconsEnabled = false
        set2.setColor(.red)
        set2.setCircleColor(.red)
        set2.lineWidth = 1
        set2.circleRadius = 0
        set2.drawCircleHoleEnabled = false
        set2.formSize = 15
        
        
        let data = LineChartData(dataSets: [set1, set2])
        
        chartView.data = data
    }
    

}
