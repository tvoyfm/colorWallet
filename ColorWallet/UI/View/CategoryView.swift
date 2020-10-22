//
//  CategoryView.swift
//  SkillTest
//
//  Created by BCS QA on 11.10.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

@IBDesignable
class CategoryView: UIView {
    
    private var timer       = Timer()
    private var timeAnim    = Double(3)

    let color1 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let color2 = #colorLiteral(red: 0.9187817259, green: 0.9187817259, blue: 0.9187817259, alpha: 1)

    var gradientView    = GradientView()
    var tableView       = UITableView()
      
    override func layoutSubviews() {
        layer.cornerRadius = 15
  
        setupTableView()
        setupConstraints()

        //timer = Timer.scheduledTimer(timeInterval: timeAnim, target: self, selector: #selector(updateColors), userInfo: nil, repeats: true)
    }
    
    func setupTableView() {
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        
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
 
    @objc func updateColors(){
        if backgroundColor == color1{
            UIView.animate(withDuration: timeAnim, animations: {
                self.layer.backgroundColor = self.color2.cgColor
            })
        } else {
            UIView.animate(withDuration: timeAnim, animations: {
                self.layer.backgroundColor = self.color1.cgColor
            })
        }
    }
    
    // Gradient :)
    func setupGradient() {
        gradientView.alpha = 0.1
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gradientView)
        gradientView.constraintInto(self)
    }
}

extension CategoryView: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categories = CategoryStorage.data.allCategories()
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categories = CategoryStorage.data.allCategories()
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        cell.nameLabel.text  = categories[indexPath.row].name
        cell.sumLabel.text   = String(categories[indexPath.row].sum)
        cell.colorView.backgroundColor = UIColor(hexString: categories[indexPath.row].colorHEX)
           
       return cell
    }
}
