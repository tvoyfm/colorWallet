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

      var balanceLabel = BalanceLabel()
      var gradientView = GradientView()
      
      override func layoutSubviews() {
        layer.cornerRadius = 15
        setupGradient()
      }
      
      func setupGradient() {
        gradientView.alpha = 0.7
        
        addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
          
        NSLayoutConstraint.activate([
          gradientView.topAnchor.constraint(equalTo: topAnchor),
          gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
          gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
          gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }


}
