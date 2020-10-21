//
//  Balance.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation

class Balance {
    static let data = Balance()
    
    let storage = CategoryStorage.data
    var value = Double()
    
    init() {
        updateBalance()
    }
    
    func updateBalance() {
        value = storage.sum(nil)
    }
    
    var formattingBalance: String {
        var b = String()
        let balanceDouble = String(format: "%.2f", value)
        
        b = "\(balanceDouble) ₽"
        return b
    }
}


