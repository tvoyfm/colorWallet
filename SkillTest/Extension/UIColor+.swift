//
//  UIColor.swift
//  SkillTest
//
//  Created by BCS QA on 03.10.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

extension UIColor {
    // return random UIColor
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1)
    }
}
