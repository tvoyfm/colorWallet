//
//  DateChooserView.swift
//  ColorWallet
//
//  Created by BCS QA on 18.11.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class DateChooserView: UIView {
    
//MARK: - Objects
    var dateLabel = UILabel()
    var dateSegmentControl = UISegmentedControl()
    var gradientView = GradientView()
    
//MARK: - Parameters
    var height = CGFloat(60)
    var radius = CGFloat(15)
    var safeUpDown = CGFloat(6)
    var safeLR = CGFloat(7)

//MARK: - Init View
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        layer.cornerRadius = radius
        
        setupLabel()
        setupSegment()
        setupGradient()
        
        constraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Init objects
    func setupLabel() {
        dateLabel.text = "с 23 октября по 23 декабря"
        dateLabel.textAlignment = .center
        dateLabel.clipsToBounds = true
        dateLabel.font = UIFont(name: "Montserrat-Bold", size: 13)
        dateLabel.textColor = .white
    }
    
    func setupSegment() {
        let items = ["Неделя", "Месяц", "Квартал", "Все"]
        dateSegmentControl = UISegmentedControl(items: items)
        
        let backSelectColor = UIColor(hexString: "#000000", alpha: 0.3)
        let backColor = UIColor(hexString: "#000000", alpha: 0.1)
        
        let attributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 13)
        ]
        
        dateSegmentControl.selectedSegmentTintColor = backSelectColor
        dateSegmentControl.backgroundColor = backColor
        dateSegmentControl.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        //dateSegmentControl.selectedSegmentIndex = 0
    }
    
    func setupGradient() {
        addSubview(gradientView)
        gradientView.bounds = self.bounds
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.constraintInto(self)
    }
        
    func constraintViews() {
        for v in [dateLabel, dateSegmentControl] {
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            dateSegmentControl.topAnchor.constraint(equalTo: topAnchor, constant: safeUpDown),
            dateSegmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: safeLR),
            dateSegmentControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -safeLR),
            dateSegmentControl.bottomAnchor.constraint(equalTo: centerYAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: safeLR),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -safeLR),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeUpDown)
        ])
    }
    
//MARK: - Functions
    func setText(_ text: String?) {
        self.dateLabel.text = text
    }

}
