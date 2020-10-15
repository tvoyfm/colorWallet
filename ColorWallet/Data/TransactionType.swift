//
//  TransactionType.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation

public enum TransactionType {
    
    case debit
    case credit
    
    public var description: String {
            switch self {
            case .debit:
                return "Расходы"
            case .credit:
                return "Доходы"
        }
    }
    
}
