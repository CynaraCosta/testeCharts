//
//  ViewController.swift
//  testeCharts
//
//  Created by Cynara Costa on 04/08/22.
//

import UIKit
import SwiftCharts
import Charts

class ViewController: UIViewController {

    var chartView: BarsChart!
    
    let rawData = [
        ("Jan", 145.89),
        ("Fev", 345.3),
        ("Mar", 121.90),
        ("Abr", 89.90),
        ("Mai", 450.89),
        ("Jun", 320.89),
        ("Jul", 345.99),
        ("Ago", 123.49),
        ("Set", 64.89),
        ("Out", 249.89),
        ("Nov", 679.89),
        ("Dez", 590.89),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createChart()
        //createSwiftChart()
    }
    
    // swiftcharts
    private func createSwiftChart(){
        let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 800, by: 100))
        let sFrame = CGRect(x: 0, y: 270, width: self.view.frame.width, height: 400)
        let barsArray = [("Jan", 100), ("Fev", 450.90), ("Mar", 800)]
        let chart = BarsChart(frame: sFrame, chartConfig: chartConfig, xTitle: "Meses", yTitle: "Reais", bars: barsArray, color: UIColor.blue, barWidth: 40)
        self.view.addSubview(chart.view)
        self.chartView = chart
    }
    
    // charts
    private func createChart(){
        // Create bar chart
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width ))
        barChart.doubleTapToZoomEnabled = false
        barChart.pinchZoomEnabled = false
        barChart.drawBarShadowEnabled = false
        barChart.drawGridBackgroundEnabled = false
        barChart.drawBordersEnabled = false
        barChart.borderColor = .label
        barChart.animate(yAxisDuration: 0.5 , easingOption: .linear)
        barChart.highlightPerTapEnabled = false

        
        // Configure the axis
        let xAxis = barChart.xAxis
        let rightAxis = barChart.rightAxis
        rightAxis.enabled = false
        
        // Configure legend
        let legend = barChart.legend
        
        // Supply data
        var entries = [BarChartDataEntry]()
        let names = ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
        xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        xAxis.labelRotationAngle = -25
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.setLabelCount(rawData.count, force: false)
        xAxis.granularityEnabled = false
        xAxis.axisMaximum = Double(rawData.count)

        barChart.leftAxis.enabled = false
        //let leftAxis = barChart.leftAxis
        //leftAxis.drawTopYLabelEntryEnabled = true
        //leftAxis.drawAxisLineEnabled = true
        //leftAxis.drawGridLinesEnabled = true
        //leftAxis.granularityEnabled = false

        // setar leftaxis pra numero limitado e qual numero em questao, acho que fazer um max e min dos valores funciona
        //leftAxis.setLabelCount(names.count, force: true)
        // leftAxis.axisMinimum = rawData[]
        // leftAxis.axisMaximum = 2.5
        
        for x in 0..<names.count {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(rawData[x].1)))
        }
        
        let set = BarChartDataSet(entries: entries, label: "Meses")
        set.setColor(UIColor.red)
        //set.colors = ChartColorTemplates.pastel()
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        barChart.legend.enabled = false
        
        view.addSubview(barChart)
        barChart.center = view.center
    }


}

