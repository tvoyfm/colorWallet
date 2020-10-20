//
//  Categories.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name          : String            = ""
    @objc dynamic var sum           : Double            = 0
    @objc dynamic var colorHEX      : String            = UIColor.black.toHexString()
    @objc dynamic var type          : TransactionType   = .debit
    var transactions                : List<Transaction> = .init()

    convenience init (name: String, color: UIColor, transactionType: TransactionType) {
        self.init()
        self.name           = name
        self.colorHEX       = color.toHexString()
        self.type           = transactionType
        self.transactions   = List<Transaction>()
        self.sum            = Double(0)
    }
}
