//
//  MainViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
//MARK: - Objects
//  Views
    static var balanceView      = BalanceView()
    static var categoryView     = CategoryView()
    var addTransactionButton    = AddMainButton(type: .custom)
    var addCategoryButton       = AddSecondButton(type: .custom)
//  ViewControllers
    let addCategoryVC           = AddCategoryViewController()
    let addTransactionVC        = AddTransactionViewController()
    let chartsVC                = ChartsViewController()
//  Parameters
//  -- padding for left and right
    let paddingLR               = CGFloat(15)
    let paddingInside           = CGFloat(10)
//  -- data storage
    let storage = CategoryStorage.data
 
//MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        storage.printAll()
    }
    
    func setupView() {
        configAddTransactionButton()
        configAddCategoryButton()
        configBalanceView()
        configCategoryView()
        configView()
    }
    
//MARK: - Config
        func configAddTransactionButton() {
            addTransactionButton.setTitle("Записать операцию", for: .normal)
            addTransactionButton.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
        }

        func configAddCategoryButton() {
            addCategoryButton.setTitle("+", for: .normal)
            addCategoryButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        }
    
        func configBalanceView() {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(chartPresent))
            MainViewController.balanceView.addGestureRecognizer(gesture)
        }

    func configCategoryView() {
        MainViewController.categoryView.tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        MainViewController.categoryView.tableView.dataSource = self
        MainViewController.categoryView.tableView.delegate = self
    }
    
        // configConstraints
        func configView() {
            let balance = MainViewController.balanceView
            let category = MainViewController.categoryView
            
            let safeArea = view.safeAreaLayoutGuide
            
            for v in [balance, category, addCategoryButton, addTransactionButton] {
                view.addSubview(v)
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            
            NSLayoutConstraint.activate([
            // Balance
                balance.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
                balance.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                balance.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                balance.heightAnchor.constraint(equalToConstant: 80),
            // Category
                category.topAnchor.constraint(equalTo: balance.bottomAnchor, constant: paddingInside),
                category.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                category.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                category.bottomAnchor.constraint(equalTo: addTransactionButton.topAnchor, constant: -paddingInside),
            // Add category button
                addCategoryButton.centerXAnchor.constraint(equalTo: category.centerXAnchor),
                addCategoryButton.bottomAnchor.constraint(equalTo: category.bottomAnchor, constant: -paddingInside),
                addCategoryButton.heightAnchor.constraint(equalToConstant: addCategoryButton.buttonSize),
                addCategoryButton.widthAnchor.constraint(equalTo: category.widthAnchor, constant: -paddingInside*2),
            // Add transaction button
                addTransactionButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingInside),
                addTransactionButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                addTransactionButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                addTransactionButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }

//MARK: - Actions
    @objc func addCategory() {
        present(addCategoryVC, animated: true, completion: nil)
    }
    
    @objc func addTransaction(){
        present(addTransactionVC, animated: true, completion: nil)
    }
    
    @objc func chartPresent() {
        present(chartsVC, animated: true, completion: nil)
    }
    
//MARK: - Update
    static func updateView() {
        balanceView.updateLabelBalance()
        categoryView.updateCategories()
        categoryView.tableView.reloadData()
    }
    
//MARK: - TableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.categoryView.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        let c = MainViewController.categoryView.categories[indexPath.row]
        
        cell.nameLabel.text  = c.name
        cell.sumLabel.text   = c.formattedSum
        cell.colorView.backgroundColor = UIColor(hexString: c.colorHEX)
        cell.category = c
        
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        let vc = TransactionViewController()
        self.present(vc, animated: true, completion: nil)
        vc.category = cell.category!
    }

}


