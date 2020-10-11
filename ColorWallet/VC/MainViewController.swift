//
//  MainViewController.swift
//  SkillTest
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.

/*
Главный экран
- Выводится текущий баланс и список категорий расходов
- Есть кнопка для добавления дохода ✅
-- Увеличивает баланс, доходы кэшируются на телефоне
- Можно создать новую категорию расходов
-- Кэшируется после создания
- Можно перейти на график расходов/доходов

Экран графика расходов/доходов
- Можно выбрать промежуток: неделя/месяц/квартал/всё время
- Для выбранного промежутка показывается график расходов и доходов по дням

Экран категории расходов
- Кнопка для перехода на просмотр графика платежей
- Выводятся все расходы в этой категории с датой расхода
- Можно создать новый расход (расход кэшируются)

Экран графика платежей
- Можно выбрать промежуток: неделя/месяц/квартал/всё время
- Для выбранного промежутка показывается график расходов по данной категории
*/

import UIKit

class MainViewController: UIViewController {
// sample date
//    let category: Category = {
//        let withD = Withdraw()
//        let c = Category()
//
//        withD.category = c
//
//        c.name       = "Eda"
//        c.sum        = 1302
//        c.colorHEX   = UIColor.red.toHexString()
//        c.withdrawals.append(withD)
//        c.withdrawals.append(withD)
//
//        return c
//    }()
    
//  Views
    var balanceView = BalanceView()
    var categoryView = CategoryView()
    var addWithdrawButton = AddButton(type: .custom)
    var addCategoryButton = AddButton(type: .custom)
    
//  View parameters
//  -- padding for left and right
    let paddingLR = CGFloat(15)
    let paddingInside = CGFloat(10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

//        CategoryStore.data.write(category)
        
        CategoryStore.data.printAll()
    }
    
// View initialization
    func setupView() {
        configWithdrawButton()
        configBalanceView()
        configCategoryView()
    }

        func configWithdrawButton() {
            addWithdrawButton.setTitle("Добавить расходы", for: .normal)
            
            view.addSubview(addWithdrawButton)
            NSLayoutConstraint.activate([
                addWithdrawButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -paddingInside),
                addWithdrawButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
                addWithdrawButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
                addWithdrawButton.heightAnchor.constraint(equalToConstant: 60)
            ])
        }

        //    func configCategoryButton() {
        //        addCategoryButton.setTitle("Добавить категорию", for: .normal)
        //
        //        view.addSubview(addCategoryButton)
        //        NSLayoutConstraint.activate([
        //            addCategoryButton.bottomAnchor.constraint(equalTo: addWithdrawButton.topAnchor, constant: -paddingInside),
        //            addCategoryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
        //            addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
        //            addCategoryButton.heightAnchor.constraint(equalToConstant: 20)
        //        ])
        //    }

        func configBalanceView(){
            balanceView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(balanceView)
            
            NSLayoutConstraint.activate([
                balanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: paddingInside),
                balanceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
                balanceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
                balanceView.heightAnchor.constraint(equalToConstant: 80)
            ])
        }

        func configCategoryView(){
            categoryView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(categoryView)

            NSLayoutConstraint.activate([
                categoryView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: paddingInside),
                categoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: paddingLR),
                categoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -paddingLR),
                categoryView.bottomAnchor.constraint(equalTo: addWithdrawButton.topAnchor, constant: -paddingInside)
            ])
        }
}
