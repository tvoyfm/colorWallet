//
//  GradientView.swift
//  SkillTest
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    private var timer = Timer()
    private var timeAnim = Double(1.5)
        
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .conic
        
        // default colors
        gradient.colors = [
            UIColor.blue.cgColor,
            UIColor.green.cgColor,
            UIColor.orange.cgColor,
            UIColor.red.cgColor
        ]

        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        let endY = 0.5 + frame.size.width / frame.size.height / 2
        gradient.endPoint = CGPoint(x: 1, y: endY)
        return gradient
    }()
    
    lazy var blur: UIBlurEffect = {
        let blur = UIBlurEffect(style: .regular)
        return blur
    }()
    
    lazy var blurView = UIVisualEffectView(effect: blur)
    
    override func layoutSubviews() {
        gradient.frame = bounds
        blurView.frame = bounds
        
        layer.addSublayer(gradient)
        addSubview(blurView)
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        timer = Timer.scheduledTimer(timeInterval: timeAnim, target: self, selector: #selector(updateColors), userInfo: nil, repeats: true)
    }
    
    @objc func updateColors(){
        let randColors = [
              UIColor.random().cgColor,
              UIColor.random().cgColor,
              UIColor.random().cgColor,
              UIColor.random().cgColor
          ]
        
        UIView.animate(withDuration: timeAnim, animations: {
            self.gradient.colors = randColors
        })
    }
    
    @objc func updateColors2(){
        let randColors = [
              UIColor.random().cgColor,
              UIColor.random().cgColor,
              UIColor.random().cgColor,
              UIColor.random().cgColor
          ]
        
        gradient.setColors(randColors,
                           animated: true,
                           withDuration: timeAnim,
                           timingFunctionName: .linear)
    }
}

