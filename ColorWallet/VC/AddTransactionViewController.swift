//
//  AddTransactionViewController.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

//MARK: - Objects & Parameters
// VC
    let addCategoryVC       = AddCategoryViewController()
// Views
    var headerView          = HeaderView(text: "Новая операция")
    
    var nameTextField       = MainTextField(label: "Название", placeholderText: "Введите название")
    var sumTextField        = MainTextField(label: "Cумма", placeholderText: "Введите сумму")
    var dateTextField       = MainTextField(label: "Дата", placeholderText: "Введите дату")
    var categoryTextField   = MainTextField(label: "Категория", placeholderText: "Выберите категорию")
    var addCategoryButton   = UIButton(type: .contactAdd)

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
    
    let headerHeight    = CGFloat(80)
    let textFieldHeight = CGFloat(35)
    let buttonHeight    = CGFloat(60)

   //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configSumTextField()
        configAcceptButton()
        configDateTextField()
        configCategoryTextField()
        configCategoryButton()
        
        configViews()
        
        registerForKeyboardNotifications()
    }
    
//MARK: - DeInit
    deinit {
        removeKeyboardNotifications()
    }
    
//MARK: - TextFields
    func configSumTextField() {
        sumTextField.keyboardType = .decimalPad
    }
    
    func configDateTextField() {
        datePicker.maximumDate  = NSDate() as Date
        datePicker.locale       = .init(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(updateDateField), for: .valueChanged)
        
        dateTextField.inputView = datePicker
    }
    
    func configCategoryTextField() {
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        categoryTextField.inputView = categoryPicker
    }
    
    func configCategoryButton() {
        addCategoryButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        addCategoryButton.tintColor = .label
    }

    func configViews(){
        let gesture  = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(gesture)
        
        let safeArea = view.safeAreaLayoutGuide
        
        for v in [headerView, nameTextField, sumTextField, dateTextField, categoryTextField, acceptButton, addCategoryButton] {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),
            
            nameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: paddingInside),
            nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            sumTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            sumTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: paddingInside),
            sumTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            sumTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            sumTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            dateTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            dateTextField.topAnchor.constraint(equalTo: sumTextField.bottomAnchor, constant: paddingInside),
            dateTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            dateTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            dateTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            categoryTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            categoryTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: paddingInside),
            categoryTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            categoryTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            categoryTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            addCategoryButton.centerYAnchor.constraint(equalTo: categoryTextField.centerYAnchor),
            addCategoryButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
                    
            acceptButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingInside),
            acceptButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            acceptButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            acceptButton.heightAnchor.constraint(equalToConstant: buttonHeight)
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
        dateTransaction = dateFormate.date(from: dateTextField.text ?? "01-01-2020 00:00")! as NSDate
    }
    
    @objc func addCategory() {
        addCategoryVC.afterAdd = updateView
        present(addCategoryVC, animated: true, completion: nil)
    }
        
    @objc func addTransaction() {
        let text    = nameTextField.text
        let sum     = sumTextField.text
        let date    = dateTextField.text
        
        let t = validTransaction(text: text, sum: sum, date: date)
        
        if t.complete {
            _ = Transaction(name: t.transText, date: t.transDate, sum: t.transSum, category: categoryTransaction)
            
            MainViewController.updateView()
            dismiss(animated: true, completion: nil)
            cleanView()
        }
    }
    
    func validTransaction(text: String?, sum: String?, date: String?) -> (transText: String, transSum: Double, transDate: NSDate, complete: Bool) {
        var complete = false
        var t = String()
        var s = Double()
        var d = NSDate()
        
        if (text != "" && sum != "" && date != "" && (sum?.doubleValue) != nil){
            t = text ?? ""
            s = sum?.doubleValue ?? 0
            d = dateTransaction
            
            complete = true
        }
        return (t, s, d, complete)
    }
    
//MARK: - Update
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    func updateView() {
        array = CategoryStorage.data.allCategories()
        updateCategoryField()
        updateDateField()
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
    
    @objc func updateDateField() {
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "dd-MM-yyyy HH:mm"
        dateTextField.text = dateFormate.string(from: datePicker.date)
        dateTransaction = dateFormate.date(from: dateTextField.text ?? "01-01-2020 00:00")! as NSDate
    }
    
    @objc func endEditing() {
        view.endEditing(true)
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
    
//MARK: - Keyboard Notifications
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbShow(_ notify: Notification) {
        let userInfo    = notify.userInfo
        let kbFrame     = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        acceptButton.transform = .init(translationX: 0, y: -(kbFrame.height-buttonHeight+paddingLR))
    }
    
    @objc func kbHide()  {
        acceptButton.transform = .identity
    }
    
}
