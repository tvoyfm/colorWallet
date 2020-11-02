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
//MARK: - Parameters
    let paddingLR               = CGFloat(15)
    let paddingInside           = CGFloat(10)
    let chartHeight             = CGFloat(250)
    
//MARK: - Objects
    var periodSegmentControl    = UISegmentedControl()
    var debitView               = ChartView(type: .debit)
    var creditView              = ChartView(type: .credit)
    var transactionView         = TransactionView()
    
//MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configSegmentedControl()
        configView()
    }
    
//MARK: - Config
    func configSegmentedControl() {
        let items = ["Неделя", "Месяц", "Квартал", "Все время"]
        
        periodSegmentControl = UISegmentedControl(items: items)
        periodSegmentControl.addTarget(self, action: #selector(SegmControlDidChange(_:)), for: .valueChanged)
        periodSegmentControl.selectedSegmentIndex = 3
    }
        
    func configView() {
        let safeArea = view.safeAreaLayoutGuide
        
        for v in [periodSegmentControl, debitView, creditView, transactionView] {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            debitView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            debitView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            debitView.trailingAnchor.constraint(equalTo: safeArea.centerXAnchor),
            debitView.heightAnchor.constraint(equalToConstant: chartHeight),
            
            creditView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            creditView.leadingAnchor.constraint(equalTo: safeArea.centerXAnchor),
            creditView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            creditView.heightAnchor.constraint(equalToConstant: chartHeight),
            
            transactionView.topAnchor.constraint(equalTo: creditView.bottomAnchor, constant: paddingInside),
            transactionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            transactionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            transactionView.bottomAnchor.constraint(equalTo: periodSegmentControl.topAnchor, constant: -paddingInside),
            
            periodSegmentControl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            periodSegmentControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    
//MARK: - Action
    @objc func SegmControlDidChange(_ segmControl: UISegmentedControl){
        switch segmControl.selectedSegmentIndex{
        case 0:
            updateView(days: -7)
        case 1:
            updateView(days: -30)
        case 2:
            updateView(days: -90)
        case 3:
            updateView(days: nil)
        default:
            print("def")
        }
    }
    
//MARK: - Update
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateView(days: nil)
        periodSegmentControl.selectedSegmentIndex = 3
    }
    
    func updateView(days: Int?) {
        debitView.updateByDays(days)
        creditView.updateByDays(days)
        
        transactionView.transactions = CategoryStorage.data.allTransactionsByDays(days)
        transactionView.tableView.reloadData()
        
        debitView.layoutIfNeeded()
        creditView.layoutIfNeeded()
    }
}
