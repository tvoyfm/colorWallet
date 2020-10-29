//
//  CategoryView.swift
//  SkillTest
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

@IBDesignable
class CategoryView: UIView {
    
    var categories  = CategoryStorage.data.allCategories()
    var tableView   = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutIfNeeded() {
        updateCategories()
    }
    
    func setupConstraints() {
        layer.masksToBounds = true
        
        for v in [tableView] {
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableView.constraintInto(self)
    }
    
    func updateCategories() {
        categories = CategoryStorage.data.allCategories()
    }
}
