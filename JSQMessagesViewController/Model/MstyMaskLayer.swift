//
//  MstyMaskLayer.swift
//  MSTY
//
//  Created by Maciej Trybilo on 11/03/2015.
//  Copyright (c) 2015 MSTY Ltd. All rights reserved.
//

import Foundation

class MstyMaskLayer: CALayer {
    
    override func drawInContext(ctx: CGContext) {
        
        CGContextSetFillColorWithColor(ctx, UIColor.blackColor().CGColor);

        let radius: CGFloat = 12
        
        CGContextMoveToPoint(ctx, self.bounds.width, self.bounds.height)
        CGContextAddLineToPoint(ctx, radius, self.bounds.height)
        CGContextAddArc(ctx, radius, self.bounds.height - radius, radius, CGFloat(M_PI_2), CGFloat(M_PI), 0)
        CGContextAddLineToPoint(ctx, 0, radius)
        CGContextAddArc(ctx, radius, radius, radius, CGFloat(M_PI), CGFloat(M_PI + M_PI_2), 0)
        CGContextAddLineToPoint(ctx, self.bounds.width, 0)
        
        CGContextClosePath(ctx)
        
        CGContextFillPath(ctx)
    }
    
}
