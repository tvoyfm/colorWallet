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
    // Write new category
    func addCategory(_ category: Category) {
       try! realm.write {
            realm.add(category)
        print("we add \(category.name) with type: \(category.type.desc)")
        }
    }
    
    // Write new transaction in category
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
    
    // Return sum all categories or 1 category
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
    
    // Return category array
    func allCategories() -> [Category] {
        let array = realm.objects(Category.self).toArray(ofType: Category.self) as [Category]
        return array
    }
    
    func allCategoriesByDays(_ days: Int?) -> [Category] {
        let transactions = allTransactions()
        let dateX  = NSDate().add(days: days ?? 0)
        
        var array = [Category]()
        
        if days == nil {
           array = realm.objects(Category.self).toArray(ofType: Category.self) as [Category]
        } else {
            //print("we try to calculate from \(dateX)")
            for v in transactions {
                if (v.date as Date) > dateX {
                    
                    //print(v.date, v.name, v.sum, v.category!.name)
                    var hasCategory = false
                    
                    if array.isEmpty {
                        let c = Category(name: v.category!.name, color: UIColor.init(hexString: v.category!.colorHEX), transactionType: v.category!.type)
                        c.sum += v.sum
                        array.append(c)
                    } else {
                        array.forEach({
                            if v.category!.name == $0.name {
                                if v.type == .debit {
                                 $0.sum += v.sum
                                }
                                
                                hasCategory = true
                            }
                        })
                        if hasCategory == false {
                            let c = Category(name: v.category!.name, color: UIColor.init(hexString: v.category!.colorHEX), transactionType: v.category!.type)
                            c.sum += v.sum
                            array.append(c)
                        }
                    }
                }
            }
        }
        return array
    }
    
    func allTransactions() -> [Transaction] {
        let allCategories = realm.objects(Category.self)
        var transactions = [Transaction]()

        for v in allCategories {
            for el in v.transactions {
                transactions.append(el)
            }
        }
        
        let result = transactions.sorted(by: { $0.date.compare($1.date as Date) == .orderedDescending })
        return result
    }
    
    func allTransactionsByDays(_ days: Int?) -> [Transaction] {
        var result = [Transaction]()
        
        let transactions = allTransactions()
        let dateX  = NSDate().add(days: days ?? 0)

        if days == nil {
           result = transactions
        } else {
            for v in transactions {
                if (v.date as Date) > dateX {
                    result.append(v)
                }
            }
        }

        return result
    }
    
    func sortTransactionsByCategory(category: Category, _ transaction: [Transaction]) -> [Transaction]{
        let result = transaction.filter { $0.category?.name == category.name}
        return result
    }
    
    func categoryHasTransaction(_ category: Category) -> Bool {
        var result = false
        let transactions = allTransactions()
        
        for v in transactions {
            if v.category?.name == category.name {
                result = true
                break
            }
        }
        
        return result
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
}
//MARK: - Extensions for Realm
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
