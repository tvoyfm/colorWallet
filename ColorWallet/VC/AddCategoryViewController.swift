//
//  AddCategoryViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
    
    var nameTextField       = MainTextField()
    var typeSegmentControl  = UISegmentedControl()
    var acceptButton        = AddMainButton()
//    var colorPicker         = UIColorPick
    
    let storage = CategoryStorage.data
    var type: TransactionType?
    
    //  -- padding for left and right
    let paddingLR       = CGFloat(15)
    let paddingInside   = CGFloat(25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configTypeSegmentControl()
        configNameTextField()
        configAcceptButton()
        
        constraintViews()
    }

        
    func configTypeSegmentControl() {
        let items = [TransactionType.credit.desc, TransactionType.debit.desc]
        typeSegmentControl = UISegmentedControl(items: items)
        typeSegmentControl.addTarget(self, action: #selector(typeDidChange(_:)), for: .valueChanged)
        
        view.addSubview(typeSegmentControl)
        typeSegmentControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.placeholder = "Укажите название категории"
    }
    
    func configAcceptButton() {
        acceptButton.setTitle("Добавить категорию", for: .normal)
        acceptButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        view.addSubview(acceptButton)
    }
    
    func constraintViews(){
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            typeSegmentControl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            typeSegmentControl.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 25),
            typeSegmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            typeSegmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            
            nameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: typeSegmentControl.bottomAnchor, constant: paddingInside),
            nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            nameTextField.heightAnchor.constraint(equalToConstant: 35),
            
            acceptButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingInside),
            acceptButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            acceptButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            acceptButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
        
    @objc func addCategory() {
        let text = nameTextField.text
        
        if (text != "" && type != nil) {
            let category = Category(name: text!, color: .random(), transactionType: type!)
            storage.write(category)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func typeDidChange(_ segmControl: UISegmentedControl){
        switch segmControl.selectedSegmentIndex{
        case 0: 
            type = .credit
        case 1:
            type = .debit
        default:
            print("nil type :(")
        }
    }
    

}
