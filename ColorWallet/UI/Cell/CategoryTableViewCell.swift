//
//  CategoryTableViewCell.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    let nameLabel   = UILabel()
    let sumLabel    = UILabel()
    let colorView   = UIView()
    var category    : Category?
    
    let padding     = CGFloat(7)
    let sizeColor   = CGFloat(10)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configNameLabel()
        configSumLabel()
            
        configConstraints()
        
        configColorView()
    }
    
    func configNameLabel() {
        nameLabel.font = UIFont(name: "Montserrat-Regular", size: 15)
    }
    
    func configSumLabel() {
        sumLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
    }
    
    func configColorView() {
        colorView.layer.cornerRadius = sizeColor/3
    }
    
    func configConstraints() {
        for v in [nameLabel, sumLabel, colorView] {
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: sizeColor),
            colorView.heightAnchor.constraint(equalToConstant: sizeColor),
            
            colorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sumLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: padding),
            sumLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init is fall")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
