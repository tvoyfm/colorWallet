//
//  CGFloat+.swift
//  ColorWallet
//
//  Created by BCS QA on 03.10.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

extension CGFloat {
    // return random CGFloat
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }

}
