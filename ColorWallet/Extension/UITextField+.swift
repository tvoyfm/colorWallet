//
//  UITextField+.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit
extension UITextField {
    
    func addInputAccessoryToolbar(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    func addInputAccessoryButton(title: String, target: Any, selector: Selector)  {
        let container = UIView()
        
        let padding = CGFloat(5)
        let height  = CGFloat(80)
        
        let acceptButton    = AddMainButton(label: title)
        let gesture         = UITapGestureRecognizer(target: target, action: selector)
        acceptButton.addGestureRecognizer(gesture)
        
        container.addSubview(acceptButton)
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            acceptButton.heightAnchor.constraint(equalToConstant: height),
            acceptButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding),
            acceptButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            acceptButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding)
        ])
        self.inputAccessoryView = container
    }
}
