//
//  BalanceView.swift
//  SkillTest
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

@IBDesignable
class BalanceView: UIView {
    
    var balance = 350135.66
    
    var balanceLabel = BalanceLabel()
    var gradientView = GradientView()
    
    override func layoutSubviews() {
        setupGradient()
        setupBalance()
    }
    
    func setupGradient() {
        addSubview(gradientView)
        
        gradientView.bounds = self.bounds
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupBalance() {
        addSubview(balanceLabel)
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        balanceLabel.text = "\(balance) ₽"
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: topAnchor),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            balanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
