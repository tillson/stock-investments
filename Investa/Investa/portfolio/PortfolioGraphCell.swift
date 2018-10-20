//
//  PortfolioGraphCell.swift
//  Investa
//
//  Created by Nicholas Grana on 10/19/18.
//  Copyright © 2018 hackgt. All rights reserved.
//

import UIKit
import Charts

class PortfolioGraphCell: UICollectionViewCell {
    
    @IBOutlet weak var lineChartView: LineChartView! {
        didSet {
            // custom UI for lineGraphView
            lineChartView.noDataText = "You have not invested yet."
            lineChartView.noDataTextColor = .white
            lineChartView.drawGridBackgroundEnabled = false
        }
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let now = Date().timeIntervalSince1970
        let hourSeconds: TimeInterval = 3600
        
        let from = now - (Double(count) / 2) * hourSeconds
        let to = now + (Double(count) / 2) * hourSeconds
        
        let values = stride(from: from, to: to, by: hourSeconds).map { (x) -> ChartDataEntry in
            let y = arc4random_uniform(range) + 50
            return ChartDataEntry(x: x, y: Double(y))
        }
        
        let set1 = LineChartDataSet(values: values, label: "")
        set1.axisDependency = .left
        set1.setColor(UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1))
        set1.lineWidth = 1.5
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.highlightColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        lineChartView.data = data
    }
    
}
