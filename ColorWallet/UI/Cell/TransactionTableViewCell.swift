//
//  TransactionTableViewCell.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    let nameLabel   = UILabel()
    let sumLabel    = UILabel()
    let dateLabel   = UILabel()
    let colorView   = UIView()
    
    let padding     = CGFloat(7)
    let sizeColor   = CGFloat(10)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configDateLabel()
        configNameLabel()
        configSumLabel()
        configColorView()
            
        configConstraints()
    }
    
    func configNameLabel() {
        nameLabel.font = UIFont(name: "Montserrat-Bold", size: 15)
    }
    
    func configSumLabel() {
        sumLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
    }
    
    func configDateLabel() {
        dateLabel.font = UIFont(name: "Montserrat-Regular", size: 9)
    }
    
    func configColorView() {
        colorView.layer.cornerRadius = sizeColor/3
    }
    
    func configConstraints() {
        for v in [nameLabel, sumLabel, dateLabel, colorView] {
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            colorView.widthAnchor.constraint(equalToConstant: sizeColor),
            colorView.heightAnchor.constraint(equalToConstant: sizeColor),
            
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: padding),
            
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            sumLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            colorView.centerYAnchor.constraint(equalTo: centerYAnchor),
                        
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
