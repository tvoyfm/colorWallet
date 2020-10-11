//
//  BalanceLabel.swift
//  SkillTest
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

@IBDesignable
class BalanceLabel: UILabel {
    
    var labelFont = UIFont(name: "Montserrat-Bold", size: 35)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    func setupLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
        font = labelFont
        textAlignment = .center
    }

}
