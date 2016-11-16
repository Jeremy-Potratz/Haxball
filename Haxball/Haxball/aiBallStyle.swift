//
//  aiBallStyle.swift
//  Haxball
//
//  Created by Jeremy Otto Potratz on 11/15/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class aiBallStyle : UIView {
    
    @IBInspectable public var fillColor: UIColor = UIColor.greenColor() {
        didSet { setNeedsLayout() }
    }
    
    override public var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .Path
    }
    
    override public var collisionBoundingPath: UIBezierPath {
        let radius = min(bounds.size.width, bounds.size.height) / 2.0
        
        return UIBezierPath(arcCenter: CGPointZero, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
    }
    
    private var shapeLayer: CAShapeLayer!
    
    public override func layoutSubviews() {
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.clearColor().CGColor
            layer.addSublayer(shapeLayer)
        }
        
        let radius = min(bounds.size.width, bounds.size.height) / 2.0
        
        shapeLayer.fillColor = fillColor.CGColor
        shapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0), radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true).CGPath
    }
}

@IBDesignable public class pdviai : UIView {
    
    @IBInspectable public var cornerRadius: CGFloat = 5 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable public var fillColor: UIColor = UIColor.blackColor() {
        didSet { setNeedsLayout() }
    }
    
    override public var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .Path
    }
    
    override public var collisionBoundingPath: UIBezierPath {
        return UIBezierPath(roundedRect: CGRect(x: -bounds.size.width / 2.0, y: -bounds.size.height / 2.0, width: bounds.width, height: bounds.height), cornerRadius: cornerRadius)
    }
    
    private var shapeLayer: CAShapeLayer!
    
    public override func layoutSubviews() {
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.clearColor().CGColor
            layer.addSublayer(shapeLayer)
        }
        
        shapeLayer.fillColor = fillColor.CGColor
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), cornerRadius: cornerRadius).CGPath
    }
}
