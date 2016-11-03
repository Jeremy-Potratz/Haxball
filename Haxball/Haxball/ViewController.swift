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
    
    var animator: UIDynamicAnimator?
    var collision : UICollisionBehavior!
    var push : UIPushBehavior!
    var gravity : UIGravityBehavior!
    var vector = CGVectorMake(1.0, 1.0)
    var ballView = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
    
    var playerView = UIView(frame: CGRect(x: 100, y: 300, width: 50, height: 50))
    
    var itemBehaviour = UIDynamicItemBehavior()

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
        view.addSubview(js)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addJS(CGRect(x: 200, y: 200, width: 50, height: 50))
        
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
        
        animator = UIDynamicAnimator(referenceView: self.view)
//        
//        
//        collision.addItem(ballView)
//        collision.addItem(playerView)
//        collision.translatesReferenceBoundsIntoBoundary = true
//        collision.collisionMode = UICollisionBehaviorMode.Everything
//        
//        
//        
//        
        
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

var animator: UIDynamicAnimator?
let collision = UICollisionBehavior()
let push = UIPushBehavior()
let gravity = UIGravityBehavior()
let vector = CGVectorMake(1.0, 1.0)

let itemBehaviour = UIDynamicItemBehavior()
//


