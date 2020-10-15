//
//  CategoryStorage.swift
//  ColorWallet
//
//  Created by BCS QA on 15.10.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryStorage {
    static let data = CategoryStorage()
    
    private let realm = try! Realm()
    
    func firstCategory() -> Category {
        var c: Category
        
        c = realm.objects(Category.self).first!
        
        return c
    }
    
    func write(_ category: Category) {
       try! realm.write {
            realm.add(category)
        print("we add \(category)")
        }
    }
    
    func add(transaction: Transaction, to category: Category) {
        try! realm.write {
            category.transactions.append(transaction)
            category.sum += transaction.sum
        }
    }
    
    func remove(transaction: Transaction, from category: Category) {
        try! realm.write {
            print("try to remove")
//            category.transactions.remove(at: 0)
//            category.sum -= transaction.sum
        }
    }
    
// return sum of all categories
    func sum() -> Double {
        let allCategories = realm.objects(Category.self)
        var s = Double()
        
        for v in allCategories { for el in v.transactions { s += el.sum } }
       
        return s
    }
    
// Utilities
    func printAll() {
        print("-----------------------")
        let allCategories = realm.objects(Category.self)
        for v in allCategories {
            print(v.name,
                  v.sum,
                  v.colorHEX)
            
            for el in v.transactions {
                print(el.inString)
            }
        }
        print("-----------------------")
    }
}
