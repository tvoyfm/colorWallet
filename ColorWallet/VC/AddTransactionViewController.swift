//
//  AddTransactionViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
// Views
    var nameTextField       = MainTextField()
    var sumTextField        = MainTextField()
    var dateTextField       = MainTextField()
    //var timeChooseView
    //var categoryView
    var acceptButton        = AddMainButton()

// Parameters
    let storage         = CategoryStorage.data
    let balance         = Balance.data
    let datePicker      = UIDatePicker()
    var dateTransaction = NSDate()

    //  -- padding for left and right
    let paddingLR       = CGFloat(15)
    let paddingInside   = CGFloat(20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configNameTextField()
        configSumTextField()
        configAcceptButton()
        configDateTextField()
        
        constraintViews()
    }

    
    func configNameTextField() {
        nameTextField.placeholder = "Название"
    }
    
    func configSumTextField() {
        sumTextField.placeholder    = "Сумма"
        sumTextField.keyboardType   = .decimalPad
    }
    
    func configDateTextField() {
        datePicker.locale = .init(identifier: "ru_RU")
        
        dateTextField.placeholder   = "Дата"
        dateTextField.inputView     = datePicker
        dateTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDateDone))
    }
    
    func configAcceptButton() {
        acceptButton.setTitle("Добавить операцию", for: .normal)
        acceptButton.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
    }
    
    func constraintViews(){
        let safeArea = view.safeAreaLayoutGuide
        
        for v in [nameTextField, sumTextField, dateTextField, acceptButton] {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
            nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            nameTextField.heightAnchor.constraint(equalToConstant: 35),
            
            sumTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            sumTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: paddingInside),
            sumTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            sumTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            sumTextField.heightAnchor.constraint(equalToConstant: 35),
            
            dateTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            dateTextField.topAnchor.constraint(equalTo: sumTextField.bottomAnchor, constant: paddingInside),
            dateTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            dateTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            dateTextField.heightAnchor.constraint(equalToConstant: 35),
            
            acceptButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingInside),
            acceptButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            acceptButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            acceptButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func tapDateDone() {
        view.endEditing(true)
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "dd-MM-yyyy HH:mm"
        dateTextField.text = dateFormate.string(from: datePicker.date)
        dateTransaction = dateFormate.date(from: dateTextField.text!)! as NSDate
    }
        
    @objc func addTransaction() {
        let text    = nameTextField.text
        let sum     = sumTextField.text
        let date    = dateTextField.text
        
        if (text != "" && sum != "" && date != nil) {
            _ = Transaction(name: text!, date: dateTransaction, sum: (sum?.doubleValue)!, category: storage.firstCategory())
            MainViewController.balanceView.updateLabelBalance()
        } else {
            print("no thanks")
        }
        
        dismiss(animated: true, completion: nil)
    }

}
