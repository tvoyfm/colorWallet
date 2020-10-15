//
//  Balance.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation

class Balance {
    var balance = Double()
    let storage = CategoryStorage.data
    
    init() {
       updateBalance()
    }
    
    func updateBalance() {
        balance = storage.sum()
    }
    
    var formattingBalance: String {
        var b = String()
        let balanceDouble = String(format: "%.2f", self.balance)
        
        b = "\(balanceDouble) ₽"
        return b
    }
}


