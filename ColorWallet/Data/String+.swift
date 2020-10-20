//
//  String+.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation

extension String {
     struct NumFormatter {
         static let instance = NumberFormatter()
     }

     var doubleValue: Double? {
         return NumFormatter.instance.number(from: self)?.doubleValue
     }

     var integerValue: Int? {
         return NumFormatter.instance.number(from: self)?.intValue
     }
}
