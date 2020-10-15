//
//  MainViewController.swift
//  SkillTest
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.

import UIKit

class MainViewController: UIViewController {
    
    let storage = CategoryStorage.data
    
//  Views
    var balanceView = BalanceView()
    var categoryView = CategoryView()
    var addWithdrawButton = AddMainButton(type: .custom)
    var addCategoryButton = AddSecondButton(type: .custom)
    
    var addCategoryVC     = AddCategoryViewController()
    
//  View parameters
//  -- padding for left and right
    let paddingLR = CGFloat(15)
    let paddingInside = CGFloat(10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        storage.printAll()
    }
    
// View initialization
    func setupView() {
        configWithdrawButton()
        configBalanceView()
        configCategoryView()
        configCategoryButton()
    }

        func configWithdrawButton() {
            addWithdrawButton.setTitle("Добавить расходы", for: .normal)
            addWithdrawButton.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
            
            view.addSubview(addWithdrawButton)
            NSLayoutConstraint.activate([
                addWithdrawButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -paddingInside),
                addWithdrawButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
                addWithdrawButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
                addWithdrawButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }

        func configBalanceView(){
            balanceView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(balanceView)
            
            NSLayoutConstraint.activate([
                balanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: paddingInside),
                balanceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
                balanceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
                balanceView.heightAnchor.constraint(equalToConstant: 80)
            ])
        }

        func configCategoryView(){
            categoryView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(categoryView)

            NSLayoutConstraint.activate([
                categoryView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: paddingInside),
                categoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
                categoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
                categoryView.bottomAnchor.constraint(equalTo: addWithdrawButton.topAnchor, constant: -paddingInside)
            ])
        }
    
        func configCategoryButton() {
            view.addSubview(addCategoryButton)
            NSLayoutConstraint.activate([
                addCategoryButton.centerYAnchor.constraint(equalTo: categoryView.centerYAnchor),
                addCategoryButton.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor),
                addCategoryButton.heightAnchor.constraint(equalToConstant: addCategoryButton.buttonSize),
                addCategoryButton.widthAnchor.constraint(equalTo: addCategoryButton.heightAnchor)
            ])
            
            addCategoryButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        }
    
    @objc func addCategory(){
        present(addCategoryVC, animated: true, completion: nil)
    }
    
    @objc func addTransaction(){
    var category = storage.firstCategory()
    var transaction = Transaction(name: "Auchan", date: NSDate(), sum: 2510.20, category: category)

    balanceView.updateLabelBalance()
    storage.printAll()
    }
    
}
