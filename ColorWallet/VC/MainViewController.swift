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
    var addTransactionButton    = AddSecondButton(type: .custom)
    var dateChooser             = DateChooserView()
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
        //storage.printAll()
    }
    
    func setupView() {
        configAddTransactionButton()
        configBalanceView()
        configCategoryView()
        configDateChooser()
        configView()
    }
    
//MARK: - Config
        func configAddTransactionButton() {
            addTransactionButton.setTitle("+", for: .normal)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(addTransaction))
            addTransactionButton.addGestureRecognizer(gesture)
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
    
        func configDateChooser() {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(datePickerPresent))
            dateChooser.addGestureRecognizer(gesture)
        }
    
        // configConstraints
        func configView() {
            let balance = MainViewController.balanceView
            let category = MainViewController.categoryView
            
            let safeArea = view.safeAreaLayoutGuide
            
            for v in [balance, category, addTransactionButton, dateChooser] {
                view.addSubview(v)
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            
            NSLayoutConstraint.activate([
            // Balance
                balance.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
                balance.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                balance.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                balance.heightAnchor.constraint(equalToConstant: view.frame.height/6.5),
            // Category
                category.topAnchor.constraint(equalTo: balance.bottomAnchor, constant: paddingInside),
                category.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                category.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                category.bottomAnchor.constraint(equalTo: addTransactionButton.topAnchor, constant: -paddingInside),
            // Add transaction button
                addTransactionButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingInside),
                addTransactionButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                addTransactionButton.heightAnchor.constraint(equalToConstant: 60),
                addTransactionButton.widthAnchor.constraint(equalToConstant: 60),
                
                dateChooser.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingInside),
                dateChooser.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
                dateChooser.heightAnchor.constraint(equalToConstant: 60),
                dateChooser.trailingAnchor.constraint(equalTo: addTransactionButton.leadingAnchor, constant: -paddingInside)
            ])
        }

//MARK: - Actions
    @objc func addCategory() {
        present(addCategoryVC, animated: true, completion: nil)
    }
    
    @objc func addTransaction(){
        if (!storage.allCategories().isEmpty){
            present(addTransactionVC, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Упс", message: "Кажется у вас нет категорий чтобы записать операцию", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Создать категорию", style: .default, handler: { action in self.addCategory() }))
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func chartPresent() {
        if !isEmpty() { present(chartsVC, animated: true, completion: nil) }
    }
    
    @objc func datePickerPresent() {
        let alert = UIAlertController(title: "Упс", message: "Тут скоро будет выбор даты", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
//MARK: - Update
    static func updateView() {
        balanceView.updateLabelBalance()
        categoryView.updateCategories()
        categoryView.tableView.reloadData()
    }
    
    func isEmpty() -> Bool {
        var result = false
        
        if (storage.allCategories().isEmpty || storage.allTransactions().isEmpty) {
            result = true
            
            let alert = UIAlertController(title: "Упс", message: "Кажется у вас не хватает данных чтобы смотреть статистику", preferredStyle: .alert)
            
            if (storage.allCategories().isEmpty) {
                alert.addAction(UIAlertAction(title: "Создать категорию", style: .default, handler: { action in self.addCategory() }))
            }
            if (!(storage.allCategories().isEmpty) && storage.allTransactions().isEmpty) {
                alert.addAction(UIAlertAction(title: "Создать транзакцию", style: .default, handler: { action in self.addTransaction() }))
            }
            
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }

        return result
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
        let cellHaveTransactions = storage.categoryHasTransaction(cell.category!) as Bool
        
        if cellHaveTransactions {
            let vc = TransactionViewController()
            self.present(vc, animated: true, completion: nil)
            vc.category = cell.category!
        } else {
            let alert = UIAlertController(title: "Упс", message: "Кажется у вас нет транзакций по этой категории", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Создать транзакцию", style: .default, handler: { action in
                self.addTransactionVC.selectCategory = cell.category
                self.addTransaction()
            }))
            alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }

}


