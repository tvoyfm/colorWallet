//
//  Transaction.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit
import RealmSwift

class Transaction: Object {
    @objc dynamic var name:     String          = ""
    @objc dynamic var date:     NSDate          = NSDate()
    @objc dynamic var sum:      Double          = 0
    @objc dynamic var category: Category?       = .init()
    dynamic var type:           TransactionType = .debit
        
    convenience init(name: String, date: NSDate, sum: Double, category: Category) {
        self.init()
        self.name       = name
        self.date       = date
        self.sum        = sum
        self.type       = category.type
        self.category   = category
        
        CategoryStorage.data.addTransaction(transaction: self, to: category)
    }
    
    var inString: String{
        let s = "\(self.date), \(self.name), \(self.sum), \(self.category!.name)"
        return s
    }
}
