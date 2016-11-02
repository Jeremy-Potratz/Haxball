//
//  ViewController.swift
//  Haxball
//
//  Created by apcsp on 11/1/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit
//import CDJoystick

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
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


