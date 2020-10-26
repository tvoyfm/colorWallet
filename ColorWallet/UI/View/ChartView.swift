//
//  ChartView.swift
//  ColorWallet
//
//  Created by BCS QA on 26.10.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit
import Charts

class ChartView: UIView {

    //MARK: - Objects
    var categories  : [Category] = CategoryStorage.data.allCategories()
    var pieView     = PieChartView()
    
    override func layoutSubviews() {
        setupChart()
        initData()
        //addBlur()
    }
    
    //MARK: - Init
    func setupChart(){
        pieView.chartDescription?.enabled   = false
        pieView.drawHoleEnabled             = false
        pieView.rotationAngle               = -90
        pieView.rotationEnabled             = false
        pieView.isUserInteractionEnabled    = false
        
        self.addSubview(pieView)
        pieView.translatesAutoresizingMaskIntoConstraints = false
        pieView.constraintInto(self)
        //pieView.animate(xAxisDuration: 1)
    }

    func initData() {
        var entries         : [PieChartDataEntry] = Array()
        var entriesColors   : [NSUIColor] = Array()
        
        for v in categories {
            if v.type == .debit {
                let sum = abs(v.sum)
                entries.append(PieChartDataEntry(value: sum, label: v.name))
                entriesColors.append(NSUIColor.init(hexString: v.colorHEX))
            }
        }

        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.drawValuesEnabled = false
        dataSet.colors = entriesColors
        pieView.data = PieChartData(dataSet: dataSet)
    }
    
    func addBlur(){
        let blur: UIBlurEffect = {
            let blur = UIBlurEffect(style: .light)
            return blur
        }()
        
        var blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bounds
        self.addSubview(blurView)
    }
    
    func updateByDays(days: Int?){
        categories = CategoryStorage.data.allCategoriesByDays(days)
        initData()
        self.layoutSubviews()
    }
}
