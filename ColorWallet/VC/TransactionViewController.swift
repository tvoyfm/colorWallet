//
//  TransactionViewController.swift
//  ColorWallet
//
//  Created by BCS QA on 28.10.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    
//MARK: - Parameters
    let paddingLR               = CGFloat(15)
    let paddingInside           = CGFloat(10)
    
//MARK: - Objects
    var headerView              = HeaderView()
    var periodSegmentControl    = UISegmentedControl()
    var transactionView         = TransactionView()
    var category                = Category()
    let storage                 = CategoryStorage.data
    
//MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configSegmentedControl()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView(nil)
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
        
        for v in [headerView, periodSegmentControl, transactionView] {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            periodSegmentControl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            periodSegmentControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            transactionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: paddingInside),
            transactionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            transactionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            transactionView.bottomAnchor.constraint(equalTo: periodSegmentControl.topAnchor, constant: -paddingInside)
        ])
    }
    
    
//MARK: - Action
    @objc func SegmControlDidChange(_ segmControl: UISegmentedControl){
        switch segmControl.selectedSegmentIndex{
        case 0:
            updateView(-7)
        case 1:
            updateView(-30)
        case 2:
            updateView(-90)
        case 3:
            updateView(nil)
        default:
            print("def")
        }
    }
    
//MARK: - Update 
    func updateView(_ days: Int?) {
        let transactions = storage.allTransactionsByDays(days)
        transactionView.transactions = storage.sortTransactionsByCategory(category: category, transactions)
        transactionView.tableView.reloadData()
        headerView.setText((transactionView.transactions.first?.category!.name)!)
    }
}
