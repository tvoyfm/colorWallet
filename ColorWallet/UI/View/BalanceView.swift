//
//  BalanceView.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class BalanceView: UIView {
    
    var data = Balance.data
    
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
        gradientView.constraintInto(self)
    }
    
    func setupBalance() {
        addSubview(balanceLabel)
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        updateLabelBalance()
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: topAnchor),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            balanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateLabelBalance() {
        data.updateBalance()
        balanceLabel.text = data.formattingBalance
    }
}
