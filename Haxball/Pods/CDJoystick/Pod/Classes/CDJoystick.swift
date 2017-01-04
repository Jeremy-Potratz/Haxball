//
//  CDJoystick.swift
//  CDJoystickSample
//
//  Created by Cole Dunsby on 2015-12-21.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

import UIKit


public struct CDJoystickData: CustomStringConvertible {
    public var velocity: CGPoint = .zero
    public var angle: CGFloat = 0.0
    public var firstTouch: CGPoint = .zero
    
    public var description: String {
        return "velocity: \(velocity), angle: \(angle)"
    }
}

@IBDesignable
open class CDJoystick: UIView {

    @IBInspectable open var substrateColor: UIColor = .lightGray { didSet { setNeedsDisplay() }}
    @IBInspectable open var substrateBorderColor: UIColor = .lightGray { didSet { setNeedsDisplay() }}
    @IBInspectable open var substrateBorderWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() }}
    
    @IBInspectable open var stickSize: CGSize = CGSize(width: 50, height: 50) { didSet { setNeedsDisplay() }}
    @IBInspectable open var stickColor: UIColor = .darkGray { didSet { setNeedsDisplay() }}
    @IBInspectable open var stickBorderColor: UIColor = .darkGray { didSet { setNeedsDisplay() }}
    @IBInspectable open var stickBorderWidth: CGFloat = 1.0 { didSet { setNeedsDisplay() }}
    
    @IBInspectable open var fade: CGFloat = 0.5 { didSet { setNeedsDisplay() }}
    
    open var trackingHandler: ((CDJoystickData) -> ())?
    
    open var initialTouch : CGPoint = .zero
    
    @IBInspectable open var vc: UIViewController!
    
    fileprivate var data = CDJoystickData()
    fileprivate var stickView = UIView(frame: CGRect(origin: .zero, size: .zero))
    fileprivate var displayLink: CADisplayLink?
    
    open var tracking = false {
        didSet {
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                self.alpha = self.tracking ? 1.0 : self.fade
            })
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {        
        displayLink = CADisplayLink(target: self, selector: #selector(CDJoystick.listen))
        displayLink?.add(to: .current, forMode: RunLoopMode.commonModes)
    }
    
    open func listen() {
        guard tracking else { return }
        trackingHandler?(data)
    }
    
    open override func draw(_ rect: CGRect) {
        alpha = fade
        
        layer.backgroundColor = substrateColor.cgColor
        layer.borderColor = substrateBorderColor.cgColor
        layer.borderWidth = substrateBorderWidth
        layer.cornerRadius = bounds.width / 2
        
        stickView.frame = CGRect(origin: .zero, size: stickSize)
        stickView.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        stickView.layer.backgroundColor = stickColor.cgColor
        stickView.layer.borderColor = stickBorderColor.cgColor
        stickView.layer.borderWidth = stickBorderWidth
        stickView.layer.cornerRadius = stickSize.width / 2
        
        if let superview = stickView.superview {
            superview.bringSubview(toFront: stickView)
        } else {
            addSubview(stickView)
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tracking = true
//        self.initialTouch = touches.first!.locationInView(self.vc.view)
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.touchesMoved(touches, with: event)
        }) 
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let firstTouch = touches.first
            let distance = CGPoint(x: location.x - bounds.size.width / 2, y: location.y - bounds.size.height / 2)
            let magV = sqrt(pow(distance.x, 2) + pow(distance.y, 2))
            
            if magV <= stickView.frame.size.width {
                stickView.center = CGPoint(x: distance.x + bounds.size.width / 2, y: distance.y + bounds.size.width / 2)
            } else {
                let aX = distance.x / magV * stickView.frame.size.width
                let aY = distance.y / magV * stickView.frame.size.width
                stickView.center = CGPoint(x: aX + bounds.size.width / 2, y: aY + bounds.size.width / 2)
            }
            
            let x = clamp(distance.x, lower: -bounds.size.width / 2, upper: bounds.size.width / 2) / (bounds.size.width / 2)
            let y = clamp(distance.y, lower: -bounds.size.height / 2, upper: bounds.size.height / 2) / (bounds.size.height / 2)

            data = CDJoystickData(velocity: CGPoint(x: x, y: y), angle: -atan2(x, y), firstTouch: (self.initialTouch))
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        reset()
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        reset()
    }
    
    fileprivate func reset() {
        tracking = false
        data = CDJoystickData()
        self.initialTouch = .zero
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.stickView.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        }) 
    }
    
    fileprivate func clamp<T: Comparable>(_ value: T, lower: T, upper: T) -> T {
        return min(max(value, lower), upper)
    }
    
}
