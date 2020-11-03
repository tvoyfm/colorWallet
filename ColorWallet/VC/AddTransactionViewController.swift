//
//  AddTransactionViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

//MARK: - Objects & Parameters
// Views
    var headerView          = HeaderView(text: "Новая операция")
    
    var nameTextField       = MainTextField(label: "Название", placeholderText: "Введите название", hasCloseButton: true)
    var sumTextField        = MainTextField(label: "Cумма", placeholderText: "Введите сумму", hasCloseButton: true)
    var dateTextField       = MainTextField(label: "Дата", placeholderText: "Введите дату", hasCloseButton: true)
    var categoryTextField   = MainTextField(label: "Категория", placeholderText: "Выберите категорию", hasCloseButton: false)

    var acceptButton        = AddMainButton(label: "Добавить")

// Parameters
    var array           : [Category] = []
    var selectCategory  : Category?
    let datePicker      = UIDatePicker()
    let categoryPicker  = UIPickerView()
    
// For add
    var dateTransaction = NSDate()
    var categoryTransaction = Category()

    //  -- padding for left and right
    let paddingLR       = CGFloat(15)
    let paddingInside   = CGFloat(25)
   
//MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configSumTextField()
        configAcceptButton()
        configDateTextField()
        configCategoryTextField()
        
        constraintViews()
    }
    
//MARK: - TextFields
    func configSumTextField() {
        sumTextField.keyboardType   = .decimalPad
    }
    
    func configDateTextField() {
        datePicker.locale       = .init(identifier: "ru_RU")
        dateTextField.inputView = datePicker
        dateTextField.addInputAccessoryView(title: "Done", target: self, selector: #selector(tapDateDone))
    }
    
    func configCategoryTextField() {
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        categoryTextField.inputView = categoryPicker
    }

    func constraintViews(){
        let safeArea = view.safeAreaLayoutGuide
        
        for v in [headerView, nameTextField, sumTextField, dateTextField, categoryTextField, acceptButton] {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            nameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: paddingInside),
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
    
//MARK: - Buttons
    func configAcceptButton() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addTransaction))
        acceptButton.addGestureRecognizer(gesture)
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
            cleanView()
        }
    }
    
//MARK: - Update
    override func viewWillAppear(_ animated: Bool) {
        array = CategoryStorage.data.allCategories()
        updateCategoryField()
    }
    
        func cleanView() {
            for v in [nameTextField, sumTextField, dateTextField]{
                v.text = ""
            }
            updateCategoryField()
        }
        
            func updateCategoryField() {
                if selectCategory != nil {
                    categoryTextField.text  = selectCategory?.name
                    categoryTransaction     = selectCategory!.self
                } else {
                    categoryTextField.text  = array.first?.name
                    categoryTransaction     = array.first!.self
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
        if array.count != 0 {
            selectCategory = array[row].self
            updateCategoryField()
            self.view.endEditing(true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if array.count != 0 {
            return array[row].name
        } else {
            return ""
        }
    }
    
}
