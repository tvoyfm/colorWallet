//
//  TransactionType.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation
import RealmSwift

@objc enum TransactionType: Int, RealmEnum {
    case debit  = 0
    case credit = 1
    
    public var desc: String {
    switch self {
        case .debit:
            return "Расходы"
        case .credit:
            return "Доходы"
        }
    }

    
}
