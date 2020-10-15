//
//  Colors.swift
//  SkillTest
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import Foundation
import UIKit

public enum Color {

        case blue
        case darkBlue
        case green
        case lightGray

        public var uiColor: UIColor {
            switch self {
            case .blue:
                return #colorLiteral(red: 0.1411764706, green: 0.4549019608, blue: 0.8039215686, alpha: 1)
            case .darkBlue:
                return #colorLiteral(red: 0.04030030841, green: 0.1336947748, blue: 0.240469792, alpha: 1)
            case .green:
                return #colorLiteral(red: 0, green: 0.8784313725, blue: 0.5882352941, alpha: 1)
            case .lightGray:
                return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        }
    }

        public var cgColor: CGColor {
            return uiColor.cgColor
        }
    }
