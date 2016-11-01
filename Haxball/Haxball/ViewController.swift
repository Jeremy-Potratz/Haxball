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
    
//    var animator : UIDynamicAnimator? = nil
//    var attachmentBehavior: UIAttachmentBehavior!
//    var pushBehavior: UIPushBehavior!
//    var itemBehavior: UIDynamicItemBehavior!
//    var gravity = UIGravityBehavior()
    
    var box : UIView?
    
    func addBox(location: CGRect) {
        let newBox = UIView(frame: location)
        newBox.backgroundColor = UIColor.redColor()
        
        view.insertSubview(newBox, atIndex: 0)
        box = newBox
    }
 
    
    var animator:UIDynamicAnimator? = nil
    let gravity = UIGravityBehavior()
    
    func createAnimatorStuff() {
        animator = UIDynamicAnimator(referenceView:self.view)
//        animator?.addBehavior(collider)
        
        gravity.addItem(box!)
        gravity.gravityDirection = CGVectorMake(0, 0.8)
        animator?.addBehavior(gravity)
        
        addBox(CGRectMake(100, 100, 30, 30))
        createAnimatorStuff()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        
        
        addBox(CGRectMake(100, 100, 30, 30))

        
        
//        animator = UIDynamicAnimator(referenceView:self.view);
//
//
//        let ballView = UIView(frame: CGRectMake(100, 200, 100, 100))
//        ballView.backgroundColor = UIColor.greenColor()
//        ballView.layer.cornerRadius = ballView.frame.size.width/2
//        ballView.clipsToBounds = true
//        ballView.layer.borderColor = UIColor.whiteColor().CGColor
//        ballView.layer.borderWidth = 5.0
//    
//        gravity.addItem(ballView)
//        gravity.gravityDirection = CGVectorMake(0, 0.8)
//        animator?.addBehavior(gravity)
//        
//        
//        
//        self.view.addSubview(ballView)
        
    }


}

