//
//  MainViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.

import UIKit

class MainViewController: UIViewController{
//MARK: - Objects
//  Views
    static var balanceView      = BalanceView()
    var categoryView            = CategoryView()
    var addTransactionButton    = AddMainButton(type: .custom)
    var addCategoryButton       = AddSecondButton(type: .custom)
//  ViewControllers
    let addCategoryVC           = AddCategoryViewController()
    let addTransactionVC        = AddTransactionViewController()
//  Parameters
//  -- padding for left and right
    let paddingLR               = CGFloat(15)
    let paddingInside           = CGFloat(10)
//  -- data storage
    let storage = CategoryStorage.data
 
//MARK: - Run
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        storage.printAll()
    }
    
    func setupView() {
        configAddTransactionButton()
        configAddCategoryButton()
        configView()
    }
    
//MARK: - Config view
        func configAddTransactionButton() {
            addTransactionButton.setTitle("Записать операцию", for: .normal)
            addTransactionButton.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
        }

        func configAddCategoryButton() {
            addCategoryButton.setTitle("+", for: .normal)
            addCategoryButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        }
    
        // configConstraints
        func configView() {
            let safeArea = view.safeAreaLayoutGuide
            
            for v in [MainViewController.balanceView, categoryView, addCategoryButton, addTransactionButton] {
                view.addSubview(v)
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            
            NSLayoutConstraint.activate([
            // Balance
                MainViewController.balanceView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
                MainViewController.balanceView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                MainViewController.balanceView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                MainViewController.balanceView.heightAnchor.constraint(equalToConstant: 80),
            // Category
                categoryView.topAnchor.constraint(equalTo: MainViewController.balanceView.bottomAnchor, constant: paddingInside),
                categoryView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                categoryView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                categoryView.bottomAnchor.constraint(equalTo: addTransactionButton.topAnchor, constant: -paddingInside),
            // Add category button
                addCategoryButton.centerXAnchor.constraint(equalTo: categoryView.centerXAnchor),
                addCategoryButton.bottomAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: -paddingInside),
                addCategoryButton.heightAnchor.constraint(equalToConstant: addCategoryButton.buttonSize),
                addCategoryButton.widthAnchor.constraint(equalTo: categoryView.widthAnchor, constant: -paddingInside*2),
            // Add transaction button
                addTransactionButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingInside),
                addTransactionButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                addTransactionButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                addTransactionButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }

//MARK: - Buttons methods
    @objc func addCategory(){
        present(addCategoryVC, animated: true, completion: nil)
    }
    
    @objc func addTransaction(){
        present(addTransactionVC, animated: true, completion: nil)
    }
    
    func update() {
        MainViewController.balanceView.updateLabelBalance()
    }
}

