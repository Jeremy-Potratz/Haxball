//
//  ViewController.swift
//  Haxball
//
//  Created by apcsp on 11/1/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit
import CDJoystick

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator : UIDynamicAnimator!
    var collision : UICollisionBehavior!
    var push : UIPushBehavior!

    var leftView = UIView()
    var rightView = UIView()
    var topLCorner = UIView()
    var topRCorner = UIView()
    var bottomLCorner = UIView()
    var bottomRCorner = UIView()
    var ballBehavior = UIDynamicItemBehavior()
    var playerBehavior = UIDynamicItemBehavior()
    
    var boundBehavior = UIDynamicItemBehavior()

    var jsActive = false
    
    var kick = UIButton()

    var b : UIDynamicItem!
    
    var bals = ball()
    var plays = player()
    
    var vector = CGVector()
    
    var pushBehavior : UIPushBehavior!

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Began")
        var location = touches.first?.locationInView(view)
        let jsXSize = 100
        let jsYSize = 100
        location!.x = location!.x - (CGFloat(jsXSize) / 2)
        location!.y = location!.y - (CGFloat(jsYSize) / 2)
        let js = addJS(CGRect(origin: location!, size: CGSize(width: jsXSize, height: jsYSize)))
        view.addSubview(js)
        js.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        let jsView = self.view.viewWithTag(999) as! CDJoystick
        jsView.tracking = false
        jsView.removeFromSuperview()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let jsView = self.view.viewWithTag(999) as! CDJoystick
        jsView.tracking = false
        jsView.removeFromSuperview()
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let jsView = view.viewWithTag(999)
        jsView?.touchesMoved(touches, withEvent: event)
    }
    

    func addJS(frame: CGRect) -> CDJoystick{
        let js = CDJoystick()
        js.vc = self
        js.frame = frame
        js.backgroundColor = .clearColor()
        js.substrateColor = .lightGrayColor()
        js.substrateBorderColor = .grayColor()
        js.substrateBorderWidth = 1.0
        js.stickSize = CGSize(width: 50, height: 50)
        js.stickColor = .darkGrayColor()
        js.stickBorderColor = .blackColor()
        js.stickBorderWidth = 2.0
        js.fade = 0.5
        js.tag = 999
        
        js.trackingHandler = { (joystickData) -> () in

            self.vector = CGVector(dx: joystickData.velocity.x/32 , dy: joystickData.velocity.y/32)
            
            let hi = joystickData.angle
            
            print(self.vector)
            
            print(hi)
            
            
            self.pushBehavior = UIPushBehavior(items: [self.plays], mode: UIPushBehaviorMode.Instantaneous)
            self.pushBehavior.pushDirection = self.vector
            self.pushBehavior.active = true
            self.animator?.addBehavior(self.pushBehavior)
        }
        
        return js
    }
    
    
    func addViews(){
        
        bals.frame = CGRect(x: 100, y: 50, width: 50, height: 50)
        plays.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        rightView.frame = CGRect(x: 0, y: 0, width: 1, height: 1000)
        leftView.frame = CGRect(x: 412, y: 0, width: 1, height: 1000)
        rightView.backgroundColor = UIColor.redColor()
        leftView.backgroundColor = UIColor.redColor()
        kick.frame = CGRect(x: 300, y: 50, width: 50, height: 50)
        kick.setImage(UIImage(named: "grayButton.png"), forState: .Normal)
        bottomLCorner.frame = CGRect(x: 0, y: -20, width: 450, height: 1)
        
        view.addSubview(bals)
        view.addSubview(plays)
        view.addSubview(rightView)
        view.addSubview(leftView)
        view.addSubview(kick)
        view.addSubview(bottomLCorner)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        animator = UIDynamicAnimator(referenceView: view)

        addViews()
        
        ballBehavior = UIDynamicItemBehavior(items: [bals])
        ballBehavior.allowsRotation = false
        ballBehavior.elasticity = 0.40
        ballBehavior.friction = 0.00
        ballBehavior.resistance = 0.0
        ballBehavior.density = 0.1
        animator?.addBehavior(ballBehavior)
        
        playerBehavior = UIDynamicItemBehavior(items: [plays])
        playerBehavior.allowsRotation = false
        playerBehavior.elasticity = 0.40
        playerBehavior.friction = 0.0
        playerBehavior.resistance = 5.0
        playerBehavior.density = 1.0
        animator?.addBehavior(playerBehavior)
        
        boundBehavior = UIDynamicItemBehavior(items: [leftView, rightView, bottomLCorner])
        boundBehavior.allowsRotation = false
        boundBehavior.elasticity = 0.0
        boundBehavior.density = 1000000
        animator?.addBehavior(boundBehavior)
        
        collision = UICollisionBehavior(items: [bals, plays, leftView, rightView, bottomLCorner])
        collision.collisionMode = UICollisionBehaviorMode.Everything
        collision.translatesReferenceBoundsIntoBoundary = false
        animator.addBehavior(collision)
        
        collision.collisionDelegate = self


        
    }
    
//    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
//    {
//        let postCollisionDirection = UIDynamicItemBehavior(items: [bals])
//        postCollisionDirection.addLinearVelocity(CGPoint(x: bals.center.x - plays.center.x, y: 200), forItem: bals)
//        animator?.addBehavior(postCollisionDirection)       
//    }


}


// need specific collision for the two balls, not all ui dynamic items ^^^^^^^^


// add two side views like out of bounds up top. then have recessed view in between for back of goal. evaluate if ballview.center == (when y = 0) so we know it passed the top of the screen


