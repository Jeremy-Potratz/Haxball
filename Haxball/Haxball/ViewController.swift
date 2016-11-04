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
    var gravity : UIGravityBehavior!
    var ballView = UIView()
    var playerView = UIView()
    var ballBehavior = UIDynamicItemBehavior()
    var playerBehavior = UIDynamicItemBehavior()
    
    var vector = CGVector()
    
    var pushBehavior : UIPushBehavior!



    func addJS(frame: CGRect){
        let js = CDJoystick()
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
        
        js.trackingHandler = { (joystickData) -> () in
            self.playerView.center.x += joystickData.velocity.x * 2
            self.playerView.center.y += joystickData.velocity.y * 2
            
            self.vector = CGVector(dx: joystickData.velocity.x, dy: joystickData.velocity.y)
            
            var hi = joystickData.angle
            
            print(self.vector)
            
            print(hi)
        }
        
        
        view.addSubview(js)
        
        
    }
    
    
    func addViews(){
        
        ballView.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        playerView.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        
        ballView.backgroundColor = UIColor.blackColor()
        ballView.layer.cornerRadius = ballView.frame.size.width/2
        ballView.clipsToBounds = true
        ballView.layer.borderColor = UIColor.blackColor().CGColor
        ballView.layer.borderWidth = 5.0
        
        playerView.backgroundColor = UIColor.greenColor()
        playerView.layer.cornerRadius = ballView.frame.size.width/2
        playerView.clipsToBounds = true
        playerView.layer.borderColor = UIColor.greenColor().CGColor
        playerView.layer.borderWidth = 5.0
        
        
        view.addSubview(ballView)
        view.addSubview(playerView)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)

        addViews()
        
        addJS(CGRect(x: 200, y: 200, width: 100, height: 100))
        
        ballBehavior = UIDynamicItemBehavior(items: [ballView])
        ballBehavior.allowsRotation = false
        ballBehavior.elasticity = 1.08
        ballBehavior.friction = 0.0
        ballBehavior.resistance = 0.0
        animator?.addBehavior(ballBehavior)
        
        
        playerBehavior = UIDynamicItemBehavior(items: [playerView])
        playerBehavior.allowsRotation = false
        playerBehavior.elasticity = 1.08
        playerBehavior.friction = 0.0
        playerBehavior.resistance = 0.0
        animator?.addBehavior(playerBehavior)
        
        pushBehavior = UIPushBehavior(items: [playerView], mode: UIPushBehaviorMode.Instantaneous)
        pushBehavior.pushDirection = vector
        pushBehavior.active = true
//        pushBehavior.magnitude = 0.15
        animator?.addBehavior(pushBehavior)
        
        collision = UICollisionBehavior(items: [ballView, playerView])
        collision.collisionMode = UICollisionBehaviorMode.Everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        collision.collisionDelegate = self


        
    }


}





























//        itemBehaviour.addItem(ballView)
//
//animator = UIDynamicAnimator(referenceView: self.view)
//
//gravity.addItem(ballView)
//
//gravity.magnitude = 0.0
//
//
//
//ballView.backgroundColor = UIColor.greenColor()
//ballView.layer.cornerRadius = ballView.frame.size.width/2
//ballView.clipsToBounds = true
//ballView.layer.borderColor = UIColor.whiteColor().CGColor
//ballView.layer.borderWidth = 5.0
//
//
//
//view.addSubview(ballView)
//
//collision.addItem(ballView)
//collision.translatesReferenceBoundsIntoBoundary = true
//
//push.addItem(ballView)
//push.pushDirection = vector
//
//
//
//itemBehaviour.elasticity = 1.2
//itemBehaviour.density = 0.0
//itemBehaviour.friction = 0.0
//animator?.addBehavior(itemBehaviour)
//animator?.addBehavior(collision)
//animator?.addBehavior(push)
//animator?.addBehavior(gravity)
//
//    let ballView = UIView(frame: CGRectMake(100, 200, 100, 100))

//


