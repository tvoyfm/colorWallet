//
//  GradientView.swift
//  ColorWallet
//
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    private var timer       = Timer()
    private var timeAnim    = Double(2)
    
    lazy var colors = [
        UIColor.blue.cgColor,
        UIColor.green.cgColor,
        UIColor.orange.cgColor,
        UIColor.red.cgColor
    ]
        
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .conic
        
        gradient.colors = colors
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        timer = Timer.scheduledTimer(timeInterval: timeAnim, target: self, selector: #selector(updateColors), userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
        blurView.frame = bounds
        
        layer.addSublayer(gradient)
        addSubview(blurView)
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        gradient.colors = colors
    }
        
    //MARK: - Animation func
    @objc func updateColors(){
        let fromColors = colors
        let toColors = [
              UIColor.random().cgColor,
              UIColor.random().cgColor,
              UIColor.random().cgColor,
              UIColor.random().cgColor
        ]
        colors = toColors
        
        gradient.setColors(toColors,
                           fromColors,
                           animated: true,
                           withDuration: timeAnim,
                           timingFunctionName: .linear)
    }
}

