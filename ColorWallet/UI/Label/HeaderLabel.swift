//
//  HeaderLabel.swift
//  ColorWallet
//
//  Created by BCS QA on 01.11.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class HeaderLabel: UILabel {

    var labelFont = UIFont(name: "Montserrat-Bold", size: 25)

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
