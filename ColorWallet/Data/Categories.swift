//
//  Categories.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    // default category
    @objc dynamic var name          = ""
    @objc dynamic var sum           = 0
    @objc dynamic var colorHEX      = UIColor.black.toHexString()
    var withdrawals                 = List<Withdraw>()
}

class CategoryStore {
    static let data = CategoryStore()
    
    private let realm = try! Realm()
    
// Write category
    func write(_ category: Category) {
       try! realm.write {
            realm.add(category)
        }
    }
    
// Add withdraw to category
    func add(withdraw: Withdraw, to category: Category) {
        // search category
        //      if find some
        //          append withdraw to category
        //          update balance category
        //          update balance main
        //      else break
        //           print error on screen
    }
    
// Utilities
    func printAll() {
        let allCategories = realm.objects(Category.self)
        for v in allCategories {
            print(v.name,
                  v.sum,
                  v.colorHEX)
            
            for el in v.withdrawals {
                print(el.stringW)
            }
        }
    }
}

