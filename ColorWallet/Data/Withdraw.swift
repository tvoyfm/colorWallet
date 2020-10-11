//
//  Withdraw.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit
import RealmSwift

class Withdraw: Object {
    @objc dynamic var name      = ""
    @objc dynamic var date      = NSDate()
    @objc dynamic var sum       = Double(0)
    @objc dynamic var category: Category?
    
    var stringW: String{
        let s = "\(self.date), \(self.name), \(self.sum)"
        return s
    }
}
