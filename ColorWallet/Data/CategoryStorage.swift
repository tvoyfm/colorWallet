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

//MARK: - Functions
    func addCategory(_ category: Category) {
       try! realm.write {
            realm.add(category)
        print("we add \(category) with type: \(category.type.desc)")
        }
    }
    
    func addTransaction(transaction: Transaction, to category: Category) {
        try! realm.write {
            category.transactions.append(transaction)
            switch category.type {
            case .credit:
                category.sum += transaction.sum
            case .debit:
                category.sum -= transaction.sum
            }
                
        }
    }

    func sum(_ c: Category?) -> Double {
        let allCategories = realm.objects(Category.self)
        var s = Double()
        
            for v in allCategories {
                for el in v.transactions {
                    if c != nil {
                        if el.category == c {
                            switch v.type {
                            case .credit:
                                s += el.sum
                            case .debit:
                                s -= el.sum
                            }
                        }
                    } else {
                        switch v.type {
                        case .credit:
                            s += el.sum
                        case .debit:
                            s -= el.sum
                        }
                    }
                }
            }
        
        return s
    }
    
    func allCategories() -> [Category] {
        let array = realm.objects(Category.self).toArray(ofType: Category.self) as [Category]
        return array
    }
   
//MARK: - Utilities
    func printAll() {
        print("-----------------------")
        let allCategories = realm.objects(Category.self)
        for v in allCategories {
            print(v.name,
                  v.sum,
                  v.colorHEX,
                  v.type.desc)
            
            for el in v.transactions {
                print(el.inString)
            }
        }
        print("-----------------------")
    }
    
    func firstCategory() -> Category {
        var c: Category
        
        c = realm.objects(Category.self).first!
        
        return c
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
