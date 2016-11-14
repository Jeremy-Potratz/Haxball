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
    
    var bals = ball()
    var plays = player()
    
    var vector = CGVector()
    
    var pushBehavior : UIPushBehavior!
    
    var start = UIButton()

    var player1Label = UILabel()
    var player2Label = UILabel()
    var scoreOne = Int()
    var scoreTwo = Int()
    
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
        
        top.backgroundColor = .whiteColor()
        bottom.backgroundColor = .whiteColor()
        topLCorner.backgroundColor = .blackColor()
        topRCorner.backgroundColor = .blackColor()
        bottomRCorner.backgroundColor = .blackColor()
        bottomLCorner.backgroundColor = .blackColor()
        
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
        
        let dist = distanceBetween(ball.center, pointTwo: player.center)
        
        if dist <= 70 {
            let postCollisionDirection = UIDynamicItemBehavior(items: [bals])
            postCollisionDirection.addLinearVelocity(CGPoint(x: bals.center.x - plays.center.x, y: bals.center.y - plays.center.y), forItem: bals)
            animator?.addBehavior(postCollisionDirection)
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        start.addTarget(self, action: "startGame", forControlEvents: .TouchDown)
        kick.addTarget(self, action: "kickBall", forControlEvents: .TouchDown)
        
        animator = UIDynamicAnimator(referenceView: view)

        addViews()
        
        let x1 = Int(bottomLCorner.center.x)
        let y1 = Int(bottomLCorner.center.y)
        
        
        scoreOne = 0
        scoreTwo = 0
        
        player1Label.center = CGPoint(x: x1 - 33, y: y1 - 3)
        player1Label.frame = CGRect(x: player1Label.center.x, y: player1Label.center.y, width: 70, height: 15)
        player1Label.font = player1Label.font.fontWithSize(13)
        player1Label.text = "Score : \(scoreOne)"
        player1Label.textColor = UIColor.whiteColor()
        
        player2Label.textColor = UIColor.whiteColor()
        player2Label.frame = CGRect(x: topLCorner.center.x - 33, y: topLCorner.center.y - 3, width: 70, height: 15)
        player2Label.font = player2Label.font.fontWithSize(13)
        player2Label.text = "Score : \(scoreTwo)"
        
        view.addSubview(player1Label)
        view.addSubview(player2Label)
        view.bringSubviewToFront(player1Label)
        view.bringSubviewToFront(player2Label)
        bottomLCorner.bringSubviewToFront(player1Label)
        topRCorner.bringSubviewToFront(player2Label)
        
        
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

        beginGame()
        
    }
    
    func startGame() {
        
        bals.center = CGPoint(x: 200, y: 300)
        
        start.hidden = true
        
        ballBehavior.density = 0.1
        
        ballBehavior.resistance = 0.0
        
        playerBehavior.resistance = 5.0
        
        // maybe everytime someone scores make resistance less to make the game more crazy / more elasticity
        
        animator.updateItemUsingCurrentState(bals)
        animator.updateItemUsingCurrentState(plays)
        

        
    }
    
    func beginGame(){
        
        
        start.setTitle("Start", forState: .Normal)
        
        start.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        start.frame = CGRect(x: 173, y: 275, width: 50, height: 50)
        
        view.addSubview(start)
        
        start.hidden = false
        
        bals.center = CGPoint(x: 200, y: 300)
        
        ballBehavior.resistance = 10000000
        
        plays.center = CGPoint(x: 200, y: 575)
        
        playerBehavior.resistance = 100000000
        
        animator.updateItemUsingCurrentState(bals)
        animator.updateItemUsingCurrentState(plays)
        
        
    }
    
    func scored(){
        
        start.setTitle("Start", forState: .Normal)
        
        start.setTitleColor(.whiteColor(), forState: .Normal)
        
        start.frame = CGRect(x: 170, y: 275, width: 50, height: 50)
        
        view.addSubview(start)
        
        start.hidden = false
        
        bals.center = CGPoint(x: 200, y: 300)
        
        ballBehavior.resistance = 10000000
        
        pushBehavior.active = false
        
        plays.center = CGPoint(x: 200, y: 575)
        
        playerBehavior.resistance = 10000000
        
        animator.updateItemUsingCurrentState(bals)
        animator.updateItemUsingCurrentState(plays)
        // this was what we were missing ^^^^^^^^
        
}
    
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
    {
        let first = item1 as! UIView
        let second = item2 as! UIView
        
        // can use item1.isEqual(bals) for if statement
        
        if first == bals && second == top{
            scored()
            scoreOne++
            player1Label.text = "Score: \(scoreOne)"
        }
        if first == bals && second == bottom{
            scored()
            scoreTwo++
            player2Label.text = "Score: \(scoreTwo)"
        }
        
        
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


