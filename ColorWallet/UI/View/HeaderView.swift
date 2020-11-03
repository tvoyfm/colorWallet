//
//  HeaderView.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    var headerLabel = HeaderLabel()
    var gradientView = GradientView()
    
    convenience init(text: String?) {
        self.init()
        setText(text ?? "")
    }
    
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
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setText(_ text: String?) {
        self.headerLabel.text = text
    }
}
