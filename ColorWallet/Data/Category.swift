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
    var type                        : TransactionType   = .credit
    var transactions                : List<Transaction> = .init()

    convenience init (name: String, color: UIColor, type: TransactionType) {
        self.init()
        self.name           = name
        self.colorHEX       = color.toHexString()
        self.type           = type
        self.transactions   = List<Transaction>()
        self.sum            = Double(0)
    }
}
