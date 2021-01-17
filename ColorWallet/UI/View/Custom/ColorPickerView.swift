//
//  ColorPickerView.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class ColorPickerView: UIView, UIColorPickerViewControllerDelegate {

//MARK: - Parameters
    let VC             = UIColorPickerViewController.init()
    var currentColor   = UIColor.random()
    
    var label           = UILabel()
    var labelText       = ""
    var labelHigh       = CGFloat(12.5)
    var labelFont       = UIFont(name: "Montserrat-Regular", size: 12.5)
    
    var padding         = CGFloat(7)
    var corner          = CGFloat(15)

//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configView()
    }

    convenience init(label: String) {
        self.init()
        labelText = label
        
        configView()
        configLabel()
    }
    
//MARK: - Config
    func configView() {
        layer.cornerRadius = corner
        
        backgroundColor = currentColor
        VC.selectedColor = currentColor
        
        VC.delegate = self
    }
    
    func configLabel(){
        label.text = labelText
        label.font = labelFont
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: topAnchor, constant: -padding),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: labelHigh)
        ])
    }
    
//MARK: - UIColorPicker
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        currentColor = viewController.selectedColor
        backgroundColor = currentColor
    }
}
