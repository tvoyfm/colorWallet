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
    dynamic var type:           TransactionType? = nil
    
    override init() {
        super.init()
    }
        
    convenience init(name: String, date: NSDate, sum: Double, category: Category) {
        self.init()
        self.name       = name
        self.date       = date
        self.sum        = sum
        self.category   = category
        self.type       = category.type
        
        CategoryStorage.data.addTransaction(transaction: self, to: category)
    }
    
    var inString: String{
        let s = "\(self.date), \(self.name), \(self.sum), \(self.category!.name)"
        return s
    }
    
    var formattedSum: String {
        var result: String
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        let s = formatter.string(from: NSNumber(value: sum))!
        
        switch category?.type {
            case .debit:
                result = "-\(s) ₽"
            case .credit:
                result = "+\(s) ₽"
            case .none:
                result = "0"
            }
        return result
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy HH:mm"
        var s: String
            s = formatter.string(from: date as Date)
        return s
    }

}
