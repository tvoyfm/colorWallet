//
//  Balance.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation

class Balance {
    let balance     = Double()
    let store       = CategoryStore.data
    
    func update() -> Double{
        let newBalance = Double()
            // take sum of all categories
            // sum all categories to balance
            // return new balance
        return newBalance
    }
    
    var formattingBalance: String {
        var b = String()
        b = "51 163.55 ₽"
        return b
    }
}


