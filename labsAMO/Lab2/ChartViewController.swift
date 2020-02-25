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


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Line Chart 1"
//        self.options = [.toggleValues,
//                        .toggleFilled,
//                        .toggleCircles,
//                        .toggleCubic,
//                        .toggleHorizontalCubic,
//                        .toggleIcons,
//                        .toggleStepped,
//                        .toggleHighlight,
//                        .animateX,
//                        .animateY,
//                        .animateXY,
//                        .saveToGallery,
//                        .togglePinchZoom,
//                        .toggleAutoScaleMinMax,
//                        .toggleData]
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .bottomRight
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0
        
//        let ll1 = ChartLimitLine(limit: 150, label: "Upper Limit")
//        ll1.lineWidth = 4
//        ll1.lineDashLengths = [5, 5]
//        ll1.labelPosition = .topRight
//        ll1.valueFont = .systemFont(ofSize: 10)
//
//        let ll2 = ChartLimitLine(limit: -30, label: "Lower Limit")
//        ll2.lineWidth = 4
//        ll2.lineDashLengths = [5,5]
//        ll2.labelPosition = .bottomRight
//        ll2.valueFont = .systemFont(ofSize: 10)
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
//        leftAxis.addLimitLine(ll1)
//        leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 40000
        leftAxis.axisMinimum = -50
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];

//        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
//                                   font: .systemFont(ofSize: 12),
//                                   textColor: .white,
//                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
//        marker.chartView = chartView
//        marker.minimumSize = CGSize(width: 80, height: 40)
//        chartView.marker = marker
        
        chartView.legend.form = .line
        
//        sliderX.value = 45
//        sliderY.value = 100
//        slidersValueChanged(nil)
        
        chartView.animate(xAxisDuration: 2.5)
        
        self.setDataCount(Int(0), range: UInt32(0))

    }

//    override func updateChartData() {
//        if self.shouldHideData {
//            chartView.data = nil
//            return
//        }
//
//    }

    func setDataCount(_ count: Int, range: UInt32) {
//        let values = (0..<count).map { (i) -> ChartDataEntry in
//            let val = Double(arc4random_uniform(range) + 3)
//            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "icon"))
//
//        }
        var values: [ChartDataEntry] = []
        
        for i in 1..<6 {
            let ii = i * 1000
            let x = Double(ii)
//            let y = (Double(ii) * log(Double(ii))) / 1000
            let y = pow(Double(ii), 2.0) / 1000

            
            values.append(ChartDataEntry(x: x, y: y))
        }
        
        
        
        
        let set1 = LineChartDataSet(entries: values, label: "Теоретично")
        set1.drawIconsEnabled = false
        
//        set1.lineDashLengths = [5, 2.5]
//        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 0
        set1.drawCircleHoleEnabled = false
//        set1.valueFont = .systemFont(ofSize: 9)
//        set1.formLineDashLengths = [5, 2.5]
//        set1.formLineWidth = 1
        set1.formSize = 15
        
//        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
//                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
//        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
//
//        set1.fillAlpha = 1
//        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
//        set1.drawFilledEnabled = true
        
        guard let value2 = valuesSegue else {
            return
        }
        
        let set2 = LineChartDataSet(entries: value2, label: "Практичні")
        set2.drawIconsEnabled = false
                
        set2.lineDashLengths = [5, 2.5]
//        set1.highlightLineDashLengths = [5, 2.5]
        set2.setColor(.green)
        set2.setCircleColor(.green)
        set2.lineWidth = 1
        set2.circleRadius = 0
        set2.drawCircleHoleEnabled = false
        set2.valueFont = .systemFont(ofSize: 9)
        set2.formLineDashLengths = [5, 2.5]
        set2.formLineWidth = 1
        set2.formSize = 15
        
        let data = LineChartData(dataSets: [set1, set2])
        
        chartView.data = data
    }
    
//    override func optionTapped(_ option: Option) {
//        switch option {
//        case .toggleFilled:
//            for set in chartView.data!.dataSets as! [LineChartDataSet] {
//                set.drawFilledEnabled = !set.drawFilledEnabled
//            }
//            chartView.setNeedsDisplay()
//
//        case .toggleCircles:
//            for set in chartView.data!.dataSets as! [LineChartDataSet] {
//                set.drawCirclesEnabled = !set.drawCirclesEnabled
//            }
//            chartView.setNeedsDisplay()
//
//        case .toggleCubic:
//            for set in chartView.data!.dataSets as! [LineChartDataSet] {
//                set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
//            }
//            chartView.setNeedsDisplay()
//
//        case .toggleStepped:
//            for set in chartView.data!.dataSets as! [LineChartDataSet] {
//                set.mode = (set.mode == .stepped) ? .linear : .stepped
//            }
//            chartView.setNeedsDisplay()
//
//        case .toggleHorizontalCubic:
//            for set in chartView.data!.dataSets as! [LineChartDataSet] {
//                set.mode = (set.mode == .cubicBezier) ? .horizontalBezier : .cubicBezier
//            }
//            chartView.setNeedsDisplay()
//
//        default:
//            super.handleOption(option, forChartView: chartView)
//        }
//    }

//    @IBAction func slidersValueChanged(_ sender: Any?) {
//        sliderTextX.text = "\(Int(sliderX.value))"
//        sliderTextY.text = "\(Int(sliderY.value))"
//
//        self.updateChartData()
//    }
}
