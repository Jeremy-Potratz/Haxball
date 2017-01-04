//
//  aiBallStyle.swift
//  Haxball
//
//  Created by Jeremy Otto Potratz on 11/15/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class aiBallStyle : UIView {
    
    @IBInspectable open var fillColor: UIColor = UIColor.green {
        didSet { setNeedsLayout() }
    }
    
    override open var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .path
    }
    
    override open var collisionBoundingPath: UIBezierPath {
        let radius = min(bounds.size.width, bounds.size.height) / 2.0
        
        return UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
    }
    
    fileprivate var shapeLayer: CAShapeLayer!
    
    open override func layoutSubviews() {
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.clear.cgColor
            layer.addSublayer(shapeLayer)
        }
        
        let radius = min(bounds.size.width, bounds.size.height) / 2.0
        
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0), radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2.0), clockwise: true).cgPath
    }
}

@IBDesignable open class pdviai : UIView {
    
    @IBInspectable open var cornerRadius: CGFloat = 5 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable open var fillColor: UIColor = UIColor.black {
        didSet { setNeedsLayout() }
    }
    
    override open var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .path
    }
    
    override open var collisionBoundingPath: UIBezierPath {
        return UIBezierPath(roundedRect: CGRect(x: -bounds.size.width / 2.0, y: -bounds.size.height / 2.0, width: bounds.width, height: bounds.height), cornerRadius: cornerRadius)
    }
    
    fileprivate var shapeLayer: CAShapeLayer!
    
    open override func layoutSubviews() {
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.clear.cgColor
            layer.addSublayer(shapeLayer)
        }
        
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), cornerRadius: cornerRadius).cgPath
    }
}
