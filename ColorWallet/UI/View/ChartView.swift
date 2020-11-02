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
    var dataType    : TransactionType
    
    init(type: TransactionType) {
        self.dataType = type
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupChart()
        configData()
    }
    
    required init?(coder: NSCoder) {
        self.dataType = .debit
        super.init(coder: coder)
    }
    
    //MARK: - Init
    func setupChart(){
        pieView.chartDescription?.enabled   = false
        //pieView.drawHoleEnabled             = false
        pieView.holeColor                   = .systemBackground
        pieView.rotationAngle               = -90
        pieView.rotationEnabled             = false
        pieView.isUserInteractionEnabled    = false
        pieView.drawEntryLabelsEnabled      = false
        
        self.addSubview(pieView)
        pieView.translatesAutoresizingMaskIntoConstraints = false
        pieView.constraintInto(self)
    }

    func configData() {
        var entries         : [PieChartDataEntry] = Array()
        var entriesColors   : [NSUIColor] = Array()
        
        for v in categories {
            switch dataType {
            case .debit:
                if v.type == .debit {
                    let sum = abs(v.sum)
                    entries.append(PieChartDataEntry(value: sum, label: v.name))
                    entriesColors.append(NSUIColor.init(hexString: v.colorHEX))
                }
            case .credit:
                if v.type == .credit {
                    let sum = abs(v.sum)
                    entries.append(PieChartDataEntry(value: sum, label: v.name))
                    entriesColors.append(NSUIColor.init(hexString: v.colorHEX))
                }
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
        
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bounds
        self.addSubview(blurView)
    }
    
//MARK: - UPDATE
    func updateByDays(_ days: Int?){
        categories = CategoryStorage.data.allCategoriesByDays(days)
        configData()
    }
    
    override func layoutIfNeeded() {
        configData()
    }
}
