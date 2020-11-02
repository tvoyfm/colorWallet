//
//  CAGradientLayer+.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func setColors(_ toColors: [CGColor],
                   _ fromColors: [CGColor],
                   animated: Bool = true,
                   withDuration duration: TimeInterval = 0,
                   timingFunctionName name: CAMediaTimingFunctionName? = nil) {
        
        if !animated {
            self.colors = toColors
            return
        }
        
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = fromColors
        colorAnimation.toValue = toColors
        colorAnimation.duration = duration
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.fillMode = CAMediaTimingFillMode.forwards
        colorAnimation.timingFunction = CAMediaTimingFunction(name: name ?? .linear)

        add(colorAnimation, forKey: "colorsChangeAnimation")
    }
}
