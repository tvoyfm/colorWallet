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
    
    private var timer = Timer()
    private var timeAnim = Double(3)
    
    let color1 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let color2 = #colorLiteral(red: 0.9187817259, green: 0.9187817259, blue: 0.9187817259, alpha: 1)

    var balanceLabel = BalanceLabel()
    var gradientView = GradientView()
    
    private var scrollView = UIScrollView()
      
      override func layoutSubviews() {
        layer.cornerRadius = 15
        //setupGradient()
        backgroundColor = color2
        
        timer = Timer.scheduledTimer(timeInterval: timeAnim, target: self, selector: #selector(updateColors), userInfo: nil, repeats: true)
      }
      
      func setupGradient() {
        gradientView.alpha = 0.1
        
        addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
          
        gradientView.constraintInto(self)
    }
    
    @objc func updateColors(){
        if backgroundColor == color1{
            UIView.animate(withDuration: timeAnim, animations: {
                self.backgroundColor = self.color2
            })
        } else{
            UIView.animate(withDuration: timeAnim, animations: {
                self.backgroundColor = self.color1
            })
        }
    }
}
