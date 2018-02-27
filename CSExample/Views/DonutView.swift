//
//  DonutView.swift
//  CSExample
//
//  Created by David Casserly on 27/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation
import UIKit

final class DonutView: UIView {

    var percent: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    private func rectFor1PxStroke(_ rect: CGRect) -> CGRect {
        return CGRect(x: rect.origin.x + 0.5, y: rect.origin.y + 0.5,
                      width: rect.size.width - 1, height: rect.size.height - 1);
    }
    
    private func DegreesToRadians (value:Double) -> Double {
        return value * Double.pi / 180.0
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Setup context
        let ctx = UIGraphicsGetCurrentContext()!;
        ctx.setShouldAntialias(true);
        ctx.setAllowsAntialiasing(true);
        
        // Draw outer black circle
        UIColor.black.setStroke()
        let outerCirclePadding = CGFloat(5.0)
        let outerCircleInset = bounds.insetBy(dx: outerCirclePadding, dy: outerCirclePadding)
        ctx.strokeEllipse(in: rectFor1PxStroke(outerCircleInset))
        
        // Draw inner orange one
        UIColor.orange.setStroke()
        ctx.setLineWidth(3.0)
        let innerCirclePadding = CGFloat(15.0)
        let innerCircleRect = bounds.insetBy(dx: innerCirclePadding, dy: innerCirclePadding)
        // Calculate Angle, we deduct 90 because CGContextAddArc starts an arc from the x axis (3 oclock) and we want to start from 12 oclock
        let startAngle = 90.0
        let angle = (360.0 * percent) - startAngle
        let start = CGFloat(DegreesToRadians(value: -startAngle))
        let end = CGFloat(DegreesToRadians(value: Double(angle)))
        // Draw the arc
        ctx.addArc(center: center, radius: innerCircleRect.size.width / 2, startAngle: start, endAngle: end, clockwise: false)
        ctx.strokePath()
    }
    
}


 
 
 
