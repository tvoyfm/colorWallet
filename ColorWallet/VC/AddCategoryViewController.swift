//
//  AddCategoryViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {
//MARK: - Objects & Parameters
    var headerView          = HeaderView(text: "Новая категория")
    var typeSegmentControl  = UISegmentedControl()
    var nameTextField       = MainTextField(label: "Название", placeholderText: "Введите название категории")
    var acceptButton        = AddMainButton(label: "Добавить")
//    var colorPicker         = UIColorPicker (wait XCode 12)
    
    let storage = CategoryStorage.data
    var type: TransactionType?
    
    //  -- padding for left and right
    let paddingLR       = CGFloat(15)
    let paddingInside   = CGFloat(25)

//MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configTypeSegmentControl()
        configNameTextField()
        configAcceptButton()
        configView()
    }

//MARK: - Config
    func configTypeSegmentControl() {
        let items = [TransactionType.credit.desc, TransactionType.debit.desc]
        typeSegmentControl = UISegmentedControl(items: items)
        typeSegmentControl.addTarget(self, action: #selector(typeDidChange(_:)), for: .valueChanged)
    }
    
    func configNameTextField() {
        nameTextField.placeholder = "Укажите название категории"
    }
    
    func configAcceptButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addCategory))
        acceptButton.addGestureRecognizer(gesture)
    }
    
    func configView(){
        for v in [headerView, typeSegmentControl, acceptButton, nameTextField]{
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            typeSegmentControl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            typeSegmentControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: paddingInside),
            typeSegmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            typeSegmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            typeSegmentControl.heightAnchor.constraint(equalToConstant: 35),
            
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
    
//MARK: - Functions
    @objc func addCategory() {
        let text = nameTextField.text
        
        if (text != "" && type != nil) {
            let category = Category(name: text!, color: .random(), transactionType: type!)
            storage.addCategory(category)
            MainViewController.updateView()
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
    
//MARK: - Update
    override func viewWillAppear(_ animated: Bool) {
        cleanView()
    }
    
    func cleanView() {
        nameTextField.text = ""
    }

}
