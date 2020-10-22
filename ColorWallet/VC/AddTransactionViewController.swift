//
//  AddTransactionViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
// Views
    var nameTextField       = MainTextField()
    var sumTextField        = MainTextField()
    var dateTextField       = MainTextField()
    var categoryTextField   = MainTextField()
    var acceptButton        = AddMainButton()

// Parameters
    var array           : [Category] = []
    let balance         = Balance.data
    let datePicker      = UIDatePicker()
    let categoryPicker  = UIPickerView()
    
// For add
    var dateTransaction = NSDate()
    var categoryTransaction = Category()

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
        configCategoryTextField()
        
        constraintViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        array = CategoryStorage.data.allCategories()
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
    
    func configCategoryTextField() {
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        categoryTextField.placeholder   = "Категория"
        categoryTextField.inputView = categoryPicker
    }
    
    func constraintViews(){
        let safeArea = view.safeAreaLayoutGuide
        
        for v in [nameTextField, sumTextField, dateTextField, categoryTextField, acceptButton] {
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
            
            categoryTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            categoryTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: paddingInside),
            categoryTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            categoryTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            categoryTextField.heightAnchor.constraint(equalToConstant: 35),
            
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
            _ = Transaction(name: text!, date: dateTransaction, sum: (sum?.doubleValue)!, category: categoryTransaction)
            MainViewController.updateView()
            dismiss(animated: true, completion: nil)
        } else {
            print("no thanks")
        }
    }

//MARK: - UIPickerExtension
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text  = array[row].name
        categoryTransaction     = array[row].self
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row].name
    }
    
}
