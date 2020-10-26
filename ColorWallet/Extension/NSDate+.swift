//
//  NSDate+.swift
//  ColorWallet
//
//  Created by BCS QA on 26.10.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation

extension NSDate {
    func add(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self as Date)!
    }
}
