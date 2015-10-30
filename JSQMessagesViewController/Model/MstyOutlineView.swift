//
//  MstyOutlineView.swift
//  MSTY
//
//  Created by Maciej Trybilo on 11/03/2015.
//  Copyright (c) 2015 MSTY Ltd. All rights reserved.
//

import Foundation

class MstyOutlineView: UIView {
    
    var frontColor: UIColor?
    
    override func drawRect(rect: CGRect) {
        
        let radius: CGFloat = 12
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: self.bounds.width, y: self.bounds.height))
        path.addLineToPoint(CGPoint(x: radius, y: self.bounds.height))
        path.addArcWithCenter(CGPoint(x: radius, y: self.bounds.height - radius), radius: radius, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true)
        path.addLineToPoint(CGPoint(x: 0, y: radius))
        path.addArcWithCenter(CGPoint(x: radius, y: radius), radius: radius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI + M_PI_2), clockwise: true)
        path.addLineToPoint(CGPoint(x: self.bounds.width, y: 0))
        
        path.lineWidth = 2
        
        if let color = frontColor {
            color.setStroke()
        } else {
            UIColor(white: 0.8, alpha: 1).setStroke()
        }
        
        path.stroke()
    }
    
}
