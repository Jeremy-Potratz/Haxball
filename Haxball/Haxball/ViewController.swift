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
    
    var aiBall = aiBallStyle()
    var bals = ball()
    
    var animator : UIDynamicAnimator!
    var screen = UIScreen.mainScreen().bounds
    
    var collision : UICollisionBehavior!
    
    var timer:NSTimer? = nil
    var times = 0

    var top = UIView()
    var bottom = UIView()
    var topLCorner = UIView()
    var topRCorner = UIView()
    var bottomLCorner = UIView()
    var bottomRCorner = UIView()
    var ballBehavior = UIDynamicItemBehavior()
    var playerBehavior = UIDynamicItemBehavior()
    var aiBehavior = UIDynamicItemBehavior()
    
    var boundBehavior = UIDynamicItemBehavior()

    var jsActive = false
    
    var kick = UIButton()
    
    var plays = player()
    
    var vector = CGVector()
    
    var pushBehavior : UIPushBehavior!
    
    var start = UIButton()

    var player1Label = UILabel()
    var player2Label = UILabel()
    var scoreOne = Int()
    var scoreTwo = Int()
    
    var Onumber = 2
    var Mnumber = 3
    var Dnumber = 5
    
    var xdiff = Int()
    var ydiff = Int()
    
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
        let cornerWidth = (screen.width - 210) / 2
        bals.frame = CGRect(x: screen.width / 2, y: screen.height / 2, width: 50, height: 50)
        bals.tag = 333
        plays.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        plays.tag = 222
        topLCorner.frame = CGRect(x: 0, y: 0, width: cornerWidth, height: 50)
        topRCorner.frame = CGRect(x: cornerWidth + 210, y: 0, width: cornerWidth, height: 50)
        bottomLCorner.frame = CGRect(x: 0, y: screen.height - 50, width: cornerWidth, height: 50)
        bottomRCorner.frame = CGRect(x: cornerWidth + 210, y: screen.height - 50, width: cornerWidth, height: 50)
        top.frame = CGRect(x: 0, y: 2, width: 900, height: 1)
        top.center = CGPoint(x: screen.width / 2, y: 2)
        bottom.frame = CGRect(x: screen.width / 2, y: screen.height - 1, width: 900, height: 1)
        bottom.center = CGPoint(x: screen.width / 2, y: screen.height - 2)
        
        aiBall.frame = CGRect(x: 200, y: 125, width: 50, height: 50)
        
        top.backgroundColor = .whiteColor()
        bottom.backgroundColor = .whiteColor()
        topLCorner.backgroundColor = .blackColor()
        topRCorner.backgroundColor = .blackColor()
        bottomRCorner.backgroundColor = .blackColor()
        bottomLCorner.backgroundColor = .blackColor()
        
        kick.frame = CGRect(x: screen.width - 75, y: 50, width: 50, height: 50)
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
        view.addSubview(aiBall)
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
        
        let dist = distanceBetween(ball.center, pointTwo: player.center)
        
        if dist <= 70 {
            let postCollisionDirection = UIDynamicItemBehavior(items: [bals])
            postCollisionDirection.addLinearVelocity(CGPoint(x: 2*(bals.center.x - plays.center.x), y: 2*(bals.center.y - plays.center.y)), forItem: bals)
            animator?.addBehavior(postCollisionDirection)
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//         #selector(ViewController.startGame)
        start.addTarget(self, action:"startGame", forControlEvents: .TouchDown)
        
//        #selector(ViewController.kickBall)
        kick.addTarget(self, action: "kickBall", forControlEvents: .TouchDown)
        
        animator = UIDynamicAnimator(referenceView: view)

        addViews()
        startTimer()
        
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
        
        
        aiBehavior = UIDynamicItemBehavior(items: [aiBall])
        aiBehavior.allowsRotation = false
        aiBehavior.elasticity = 0.40
        aiBehavior.friction = 0.00
        aiBehavior.density = 1.0
        aiBehavior.resistance = 5.0
        animator?.addBehavior(aiBehavior)
        
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
        
        collision = UICollisionBehavior(items: [bals, plays, topLCorner, topRCorner, bottomLCorner, bottomRCorner, bottom, top, aiBall])
        collision.collisionMode = UICollisionBehaviorMode.Everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        // idea- make a seperate collision for two views and the balls so players cant go in goal
        
        collision.collisionDelegate = self

        beginGame()
        
    }
    
    func startGame() {
        
        bals.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        start.hidden = true
        
        ballBehavior.density = 0.1
        
        ballBehavior.resistance = 0.0
        
        playerBehavior.resistance = 5.0
        
        aiBehavior.resistance = 5.0
        
        animator.updateItemUsingCurrentState(bals)
        animator.updateItemUsingCurrentState(plays)
        animator.updateItemUsingCurrentState(aiBall)
        

        
    }
    
    func beginGame(){
        
        
        start.setTitle("Start", forState: .Normal)
        
        start.setTitleColor(.redColor(), forState: .Normal)
        
        start.frame = CGRect(x: screen.width / 2, y: screen.width / 2, width: 50, height: 50)
        
        view.addSubview(start)
        
        start.hidden = false
        
        bals.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        ballBehavior.resistance = 10000000
        
        plays.center = CGPoint(x: screen.width / 2, y: bals.center.y + 250)
        
        //idea - have the distance between the ball and two players be a static number
        
        playerBehavior.resistance = 100000000
        
        aiBehavior.resistance = 10000000
        
        aiBall.center = CGPoint(x: screen.width / 2, y: bals.center.y - 250)
        
        animator.updateItemUsingCurrentState(bals)
        animator.updateItemUsingCurrentState(plays)
        animator.updateItemUsingCurrentState(aiBall)
        
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onTick", userInfo: nil, repeats: true)

        
        //#selector(ViewController.onTick
    }
    
    func onTick(){
        xdiff = Int(arc4random_uniform(151)) - 75
        ydiff = Int(arc4random_uniform(151)) - 75
        
        let newX = Int(bals.center.x) + xdiff
        let newY = Int(bals.center.y) + ydiff
        
        let velX = newX - Int(aiBall.center.x)
        let velY = newY - Int(aiBall.center.y)
        
        let aiMovement = UIDynamicItemBehavior(items: [aiBall])
        aiMovement.addLinearVelocity(CGPoint(x: velX, y: velY), forItem: aiBall)
        animator?.addBehavior(aiMovement)
        
        
    }
    
    func scored(){
        
        start.setTitle("Start", forState: .Normal)
        
        start.setTitleColor(.redColor(), forState: .Normal)
        
        start.frame = CGRect(x: screen.width / 2, y: screen.width / 2, width: 50, height: 50)
        
        view.addSubview(start)
        
        start.hidden = false
        
        bals.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        ballBehavior.resistance = 10000000
        
        pushBehavior.active = false
        
        plays.center = CGPoint(x: screen.width / 2, y: bals.center.y + 250)
        
        playerBehavior.resistance = 10000000
        
        aiBall.center = CGPoint(x: screen.width / 2, y: bals.center.y - 250)
        
        aiBehavior.resistance = 10000000
        
        animator.updateItemUsingCurrentState(bals)
        animator.updateItemUsingCurrentState(plays)
        animator.updateItemUsingCurrentState(aiBall)
        
}
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
    {
        let first = item1 as! UIView
        let second = item2 as! UIView
        
        if first == bals && second == top{
            scored()
            scoreOne += 1
            player1Label.text = "Score: \(scoreOne)"
        }
        if first == bals && second == bottom{
            scored()
            scoreTwo += 1
            player2Label.text = "Score: \(scoreTwo)"
        }
        
        if first.isEqual(aiBall) && second.isEqual(bals){
            
            
            let xCreate = Int(bals.center.x) + xdiff
            let yCreate = Int(bals.center.x) + ydiff
            
            let xAI = Int(aiBall.center.x)
            let yAI = Int(aiBall.center.y)
            
            
            let slopey = (yCreate - yAI)
            let slopex = (xCreate - xAI)
            
            var numb = Int(arc4random_uniform(5))
            
            let thirds = screen.height / 3
            
            if aiBall.center.y <= thirds{
                // defense
                if numb <= Dnumber{
                    
                    let aiKick = UIDynamicItemBehavior(items: [bals])
                    aiKick.addLinearVelocity(CGPoint(x: slopex,y: slopey), forItem: bals)
                    animator?.addBehavior(aiKick)
                }
            }
            if aiBall.center.y <= thirds * 2 && aiBall.center.y > thirds{
                //midfield
                if numb <= Mnumber{
                    
                    let aiMidKick = UIDynamicItemBehavior(items: [bals])
                    aiMidKick.addLinearVelocity(CGPoint(x: slopex,y: slopey), forItem: bals)
                    animator?.addBehavior(aiMidKick)
                }
            }
            if aiBall.center.y > thirds * 2{
                // offense
                if numb <= Onumber{
                    
                    let aiOffKick = UIDynamicItemBehavior(items: [bals])
                    aiOffKick.addLinearVelocity(CGPoint(x: slopex,y: slopey), forItem: bals)
                    animator?.addBehavior(aiOffKick)
                }
            }
        }
    }


}

