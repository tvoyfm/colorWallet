//
//  TransactionView.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

@IBDesignable
class TransactionView: UIView {
    var tableView       = UITableView()
    var transactions    = CategoryStorage.data.allTransactions()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        setupTableView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupTableView() {
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.dataSource = self
    }
    
    func setupConstraints() {
        layer.masksToBounds = true
        
        for v in [tableView] {
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        tableView.constraintInto(self)
    }
}

//MARK: - TableView DataSource & Delegate
extension TransactionView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        
        let t = self.transactions[indexPath.row]
         
        cell.nameLabel.text = t.name
        cell.dateLabel.text = t.formattedDate
        cell.colorView.backgroundColor = UIColor(hexString: t.category!.colorHEX)
        cell.sumLabel.text = t.formattedSum
        
        return cell
    }
}
