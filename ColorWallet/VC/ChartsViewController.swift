//
//  ChartsViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

//    Экран графика расходов/доходов
//    - Можно выбрать промежуток: неделя/месяц/квартал/всё время
//    - Для выбранного промежутка показывается график расходов и доходов по дням

import UIKit

class ChartsViewController: UIViewController {

//MARK: - Objects
    var periodSegmentControl    = UISegmentedControl()
    var chartView               = ChartView()
    
//MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configSegmentedControl()
        configChartView()
        configView()
    }
    
//MARK: - Config
    func configSegmentedControl() {
        let items = ["Неделя", "Месяц", "Квартал", "Все время"]
        
        periodSegmentControl = UISegmentedControl(items: items)
        periodSegmentControl.addTarget(self, action: #selector(SegmControlDidChange(_:)), for: .valueChanged)
    }
    
    func configChartView() {

    }
    
    func configView() {
        let safeArea = view.safeAreaLayoutGuide
        
        for v in [periodSegmentControl, chartView] {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
        // Balance
           periodSegmentControl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
           periodSegmentControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -35),
           
           chartView.topAnchor.constraint(equalTo: safeArea.topAnchor),
           chartView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
           chartView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
           chartView.bottomAnchor.constraint(equalTo: periodSegmentControl.topAnchor, constant: -15)
        ])
    }
    
    
//MARK: - Action
    
    @objc func SegmControlDidChange(_ segmControl: UISegmentedControl){
        switch segmControl.selectedSegmentIndex{
        case 0:
            chartView.updateByDays(days: -7)
        case 1:
            chartView.updateByDays(days: -30)
        case 2:
            chartView.updateByDays(days: -90)
        case 3:
            chartView.updateByDays(days: nil)
        default:
            print("def")
        }
    }
    
//MARK: - Update
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.chartView.layoutSubviews()
    }
    
}
