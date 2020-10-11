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
    
    var scrollView = UIScrollView()
      
      override func layoutSubviews() {
        layer.cornerRadius = 15
        //setupGradient()
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
      }
      
      func setupGradient() {
        gradientView.alpha = 0.1
        
        addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
          
        gradientView.constraintInto(self)
    }
}
