//
//  CustomSegmentionView.swift
//  SkillTest
//
//  Created by BCS QA on 09.10.2020.
//  Copyright © 2020 Gleb Stolyarchuk. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentionView: UIView {
    
    // Default settings
    // --- Colors
    @IBInspectable var defaultColor = UIColor.white
    @IBInspectable var currentColor = UIColor.red
    // --- Segments
    var defaultSegmCount = 2
    var currentSegm = 0
    
    // --- Others
    @IBInspectable var radius = CGFloat(35)
    // --- Views
    // default segment
        var segment = UILabel()
    // default segment view
        var segmentView: UIStackView = {
            let v = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            v.alignment = .fill
            v.axis = .horizontal
            
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
    
    
    // ------------------------------------------------------
    
    func chooseSegm(old: UILabel, now: UILabel){
        old.backgroundColor = defaultColor
        now.backgroundColor = currentColor
    }
    
    override func layoutSubviews() {
        backgroundColor = .brown

        // setup segments
        let segment = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        segment.text = "🚧"
        segment.textAlignment = .center
        segment.backgroundColor = .yellow
        segment.layer.cornerRadius = 50
        
        let segmMass: [UILabel] = [segment, segment]
        // setup segmentView
        
        // add segment on segmentView
        for v in segmMass {
            segmentView.translatesAutoresizingMaskIntoConstraints = false
            segmentView.addSubview(v)
        }
        // add segmentView on view
        for v in [segmentView]{
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }

//       NSLayoutConstraint.activate([
//        widthAnchor.constraint(equalTo: segment.widthAnchor),
//        segmentView.widthAnchor.constraint(equalTo: segment.widthAnchor)
//       ])
    }
    
}
