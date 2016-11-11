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

    var top = UIView()
    var bottom = UIView()
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
    
    var start = UIButton()


    
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
            
            
            self.pushBehavior = UIPushBehavior(items: [self.plays], mode: UIPushBehaviorMode.Instantaneous)
            self.pushBehavior.pushDirection = self.vector
            self.pushBehavior.active = true
            self.animator?.addBehavior(self.pushBehavior)

        }
        
        return js
    }
    

    
    func addViews(){
        
        bals.frame = CGRect(x: 100, y: 50, width: 50, height: 50)
        bals.tag = 333
        plays.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        plays.tag = 222
        topLCorner.frame = CGRect(x: 0, y: 0, width: 115, height: 50)
        topRCorner.frame = CGRect(x: 325, y: 0, width: 101, height: 50)
        bottomLCorner.frame = CGRect(x: 0, y: 617, width: 115, height: 50)
        bottomRCorner.frame = CGRect(x: 325, y: 617, width: 101, height: 50)
        top.frame = CGRect(x: 116, y: 0, width: 300, height: 1)
        bottom.frame = CGRect(x: 116, y: 666, width: 250, height: 1)
        top.backgroundColor = .greenColor()
        bottom.backgroundColor = .greenColor()
//        topRCorner.constraints
        
        topLCorner.backgroundColor = .redColor()
        topRCorner.backgroundColor = .redColor()
        bottomRCorner.backgroundColor = .redColor()
        bottomLCorner.backgroundColor = .redColor()
        
        kick.frame = CGRect(x: 300, y: 50, width: 50, height: 50)
        kick.setImage(UIImage(named: "grayButton.png"), forState: .Normal)
        
        view.addSubview(top)
        view.addSubview(bals)
        view.addSubview(plays)
        view.addSubview(topRCorner)
        view.addSubview(topLCorner)
        view.addSubview(kick)
        view.addSubview(bottomLCorner)
        view.addSubview(bottomRCorner)
        view.addSubview(bottom)
    }
    
    func distanceBetween(pointOne: CGPoint, pointTwo: CGPoint) -> CGFloat{
        let XOne = pointOne.x
        let YOne = pointOne.y
        let XTwo = pointTwo.x
        let YTwo = pointTwo.y
        let distance = sqrt(pow(XOne - XTwo, 2.0) + pow(YOne - YTwo, 2.0))
        return distance
    }
    
    
    func kickBall(){
        print("Kick")
        let ball = view.viewWithTag(333)!
        let player = view.viewWithTag(222)!
        
        print(ball.center)
        print(player.center)
        print("Distance \(distanceBetween(ball.center, pointTwo: player.center))")
        
        var dist = distanceBetween(ball.center, pointTwo: player.center)
        
        if dist <= 70 {
            let postCollisionDirection = UIDynamicItemBehavior(items: [bals])
            postCollisionDirection.addLinearVelocity(CGPoint(x: bals.center.x - plays.center.x, y: bals.center.y - plays.center.y), forItem: bals)
            animator?.addBehavior(postCollisionDirection)
            
        }

        
    }
    
    func resetView(){
        
//        bals.center = CGPoint(x: 250, y: 300)
        
        let sdf = view.viewWithTag(333)
        
        sdf?.center = CGPoint(x: 250, y: 300)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start.addTarget(self, action: "startGame", forControlEvents: .TouchDown)
        kick.addTarget(self, action: "kickBall", forControlEvents: .TouchDown)
        
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
        
        boundBehavior = UIDynamicItemBehavior(items: [topRCorner, topLCorner, bottomRCorner, bottomLCorner, bottom, top])
        boundBehavior.allowsRotation = false
        boundBehavior.elasticity = 0.0
        boundBehavior.density = 1000000
        animator?.addBehavior(boundBehavior)
        
        collision = UICollisionBehavior(items: [bals, plays, topLCorner, topRCorner, bottomLCorner, bottomRCorner, bottom, top])
        collision.collisionMode = UICollisionBehaviorMode.Everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.collisionDelegate = self


        
    }
    
    func startGame() {
        
//        bals.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        bals.center = CGPoint(x: 200, y: 200)
        
        start.hidden = true
//        view.addSubview(bals)
        
        ballBehavior.density = 0.1
        
//        pushBehavior.active = true
        
    }
    
    func scored(){
        
        start.setTitle("Hello", forState: .Normal)
        
        
        start.setTitleColor(.redColor(), forState: .Normal)
        
        start.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        
        view.addSubview(start)
        
        start.hidden = false
        
        bals.center = CGPoint(x: 200, y: 200)
        
//        ballBehavior.anchored = true
        
        ballBehavior.resistance = 100
        
        
//        ballBehavior.density = 1000000000
        
        pushBehavior.active = false
        
//        bals.removeFromSuperview()
    }
    
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
    {
        var first = item1 as! UIView
        var second = item2 as! UIView
        if first == bals && second == top{
            print("Player One Scored")
            scored()
        }
        if first == bals && second == bottom{
            print("Player Two Scored")
            scored()
        }
//        resetView()
        
        
        
        // fix the joystick push after reset view
    }
    

    
//    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
//    {
//        if item1.isEqual(<#T##object: AnyObject?##AnyObject?#>)
//        let postCollisionDirection = UIDynamicItemBehavior(items: [bals])
//        postCollisionDirection.addLinearVelocity(CGPoint(x: bals.center.x - plays.center.x, y: 200), forItem: bals)
//        animator?.addBehavior(postCollisionDirection)       
//    }


}


// need specific collision for the two balls, not all ui dynamic items ^^^^^^^^


// add two side views like out of bounds up top. then have recessed view in between for back of goal. evaluate if ballview.center == (when y = 0) so we know it passed the top of the screen


