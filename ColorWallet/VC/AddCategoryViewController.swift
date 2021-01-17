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
    let colorPicker         = ColorPickerView(label: "Цвет")
    
    let storage = CategoryStorage.data
    var type: TransactionType?
    var currentColor = UIColor.clear
    var afterAdd: (() -> Void)?
    
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
        
        configTypeSegmentControl()
        configNameTextField()
        configAcceptButton()
        configColorView()
        
        configView()
        
        registerForKeyboardNotifications()
    }
    
//MARK: - DeInit
    deinit {
        removeKeyboardNotifications()
    }

//MARK: - Configuration elements
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
    
    func configColorView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(colorPickerPresent))
        colorPicker.addGestureRecognizer(gesture)
    }
    
    func configView(){
        let gesture  = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(gesture)
        
        for v in [headerView, typeSegmentControl, acceptButton, nameTextField, colorPicker]{
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: paddingInside),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            headerView.heightAnchor.constraint(equalToConstant: headerHeight),
            
            typeSegmentControl.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            typeSegmentControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: paddingInside),
            typeSegmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            typeSegmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            typeSegmentControl.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            nameTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: typeSegmentControl.bottomAnchor, constant: paddingInside),
            nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            nameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            colorPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: paddingInside),
            colorPicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            colorPicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            colorPicker.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            acceptButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -paddingInside),
            acceptButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: paddingLR),
            acceptButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -paddingLR),
            acceptButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
//MARK: - Functions
    @objc func addCategory() {
        (afterAdd!)()
        print(afterAdd)
        let text = nameTextField.text
        
        if (text != "" && type != nil) {
            let category = Category(name: text!, color: colorPicker.currentColor, transactionType: type!)
            storage.addCategory(category)
            MainViewController.updateView()
            (afterAdd!)()
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
    
    @objc func colorPickerPresent(){
        present(colorPicker.VC, animated: true, completion: nil)
    }
    
//MARK: - Update
    override func viewWillAppear(_ animated: Bool) {
        cleanView()
    }
    
    func cleanView() {
        nameTextField.text = ""
    }
    
    @objc func endEditing() {
        view.endEditing(true)
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
