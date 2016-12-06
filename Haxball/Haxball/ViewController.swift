//
//  ViewController.swift
//  Haxball
//
//  Created by apcsp on 11/1/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit
import CDJoystick
import CoreData
import AudioToolbox
//a
class subView : UIView{
    internal var vector : CGVector = .zero
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //do stuff
        let location = touches.first!.locationInView(self)
        let js = CDJoystick()
        js.frame = CGRect(x: location.x - 50, y: location.y - 50, width: 100, height: 100)
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
            self.vector = CGVector(dx: joystickData.velocity.x/8 , dy: joystickData.velocity.y/8)
        }
        self.addSubview(js)
        js.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //delete joysticks
        let js = self.viewWithTag(999)
        self.vector = .zero
        js?.touchesEnded(touches, withEvent: event)
        for i in self.subviews{
            i.removeFromSuperview()
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        //delete joysticks
        let js = self.viewWithTag(999)
        self.vector = .zero
        js?.touchesCancelled(touches, withEvent: event)
        for i in self.subviews{
            i.removeFromSuperview()
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //send data
        let js = self.viewWithTag(999)
        js?.touchesMoved(touches, withEvent: event)
    }
}

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var scoreLimit : Int!
    
    var checkFetchArray : [String] = []
    
    var data = [NSManagedObject]()
    
    let bottomView = subView()
    let topView = subView()
    
    var aiBall = aiBallStyle()
    var ballView = ball()
    var secondPlayer = player()
    
    let index = 0
    var pauseIndex = 0
    
    var mode: String = ""
    
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
    
    var topGoal = UIView()
    var bottomGoal = UIView()
    
    var ballBehavior = UIDynamicItemBehavior()
    var playerBehavior = UIDynamicItemBehavior()
    var aiBehavior = UIDynamicItemBehavior()
    var secondBehavior = UIDynamicItemBehavior()
    var goalCollision : UICollisionBehavior!
    
    var boundBehavior = UIDynamicItemBehavior()

    var jsActive = false
    
    var kick = UIButton()
    var secondKickButton = UIButton()
    
    var firstPlayer = player()
    
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
    
    var pause = UIButton()
    
    var totalCoin = ""
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        var location = touches.first?.locationInView(view)
//        let jsXSize = 100
//        let jsYSize = 100
//        location!.x = location!.x - (CGFloat(jsXSize) / 2)
//        location!.y = location!.y - (CGFloat(jsYSize) / 2)
//        let js = addJS(CGRect(origin: location!, size: CGSize(width: jsXSize, height: jsYSize)))
//        view.addSubview(js)
//        if location!.y <= screen.height{
//            topView.addSubview(js)
//        }
//        else{
//            bottomView.addSubview(js)
//        }
//        js.touchesBegan(touches, withEvent: event)
//        
//    }
    
//    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
//        let jsView = self.view.viewWithTag(999) as! CDJoystick
//        jsView.tracking = false
//        jsView.removeFromSuperview()
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let jsView = self.view.viewWithTag(999) as! CDJoystick
//        jsView.tracking = false
//        jsView.removeFromSuperview()
//    }
//
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let topVector = topView.vector
//        let bottomVector = bottomView.vector
//        
//        let topPushBehavior = UIPushBehavior(items: [self.secondPlayer], mode: UIPushBehaviorMode.Instantaneous)
//        topPushBehavior.pushDirection = topVector
//        topPushBehavior.active = true
//        self.animator?.addBehavior(topPushBehavior)
//        
//        let bottomPushBehavior = UIPushBehavior(items: [self.firstPlayer], mode: UIPushBehaviorMode.Instantaneous)
//        bottomPushBehavior.pushDirection = bottomVector
//        bottomPushBehavior.active = true
//        self.animator?.addBehavior(bottomPushBehavior)
//    }
    

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
            
            

            self.vector = CGVector(dx: joystickData.velocity.x/24 , dy: joystickData.velocity.y/24)
            if self.mode == "twoPlayers"{
                if joystickData.firstTouch.y > self.screen.height / 2{
                    self.pushBehavior = UIPushBehavior(items: [self.firstPlayer], mode: UIPushBehaviorMode.Instantaneous)
                    self.pushBehavior.pushDirection = self.vector
                    self.pushBehavior.active = true
                    self.animator?.addBehavior(self.pushBehavior)
                }
                else{
                    self.pushBehavior = UIPushBehavior(items: [self.secondPlayer], mode: UIPushBehaviorMode.Instantaneous)
                    self.pushBehavior.pushDirection = self.vector
                    self.pushBehavior.active = true
                    self.animator?.addBehavior(self.pushBehavior)
                }
            }
            else{
                self.pushBehavior = UIPushBehavior(items: [self.firstPlayer], mode: UIPushBehaviorMode.Instantaneous)
                self.pushBehavior.pushDirection = self.vector
                self.pushBehavior.active = true
                self.animator?.addBehavior(self.pushBehavior)
            }
        }
        
        return js
    }
    

    
    func addViews(){
        
        topView.frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height / 2)
        topView.backgroundColor = .blackColor()
        topView.tag = 109
        topView.alpha = 0.5
        
        
        bottomView.frame = CGRect(x: 0, y: screen.height / 2, width: screen.width, height: screen.height / 2)
        bottomView.backgroundColor = .redColor()
        bottomView.tag = 108
        bottomView.alpha = 0.5
        
        let cornerWidth = (screen.width - 210) / 2
        ballView.frame = CGRect(x: screen.width / 2, y: screen.height / 2, width: 50, height: 50)
        ballView.tag = 333
        secondPlayer.frame = CGRect(x: screen.width / 2, y: screen.height / 5, width: 50, height: 50)
        secondPlayer.tag = 777
        firstPlayer.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        firstPlayer.tag = 222
        topLCorner.frame = CGRect(x: 0, y: 0, width: cornerWidth, height: 50)
        topRCorner.frame = CGRect(x: cornerWidth + 210, y: 0, width: cornerWidth, height: 50)
        bottomLCorner.frame = CGRect(x: 0, y: screen.height - 50, width: cornerWidth, height: 50)
        bottomRCorner.frame = CGRect(x: cornerWidth + 210, y: screen.height - 50, width: cornerWidth, height: 50)
        top.frame = CGRect(x: 0, y: 2, width: 900, height: 1)
        top.center = CGPoint(x: screen.width / 2, y: 2)
        bottom.frame = CGRect(x: screen.width / 2, y: screen.height - 1, width: 900, height: 1)
        bottom.center = CGPoint(x: screen.width / 2, y: screen.height - 2)
        
        aiBall.frame = CGRect(x: 200, y: 125, width: 50, height: 50)
        
        

        
        topGoal.frame = CGRect(x: 0, y: 0, width: cornerWidth * 4, height: 50)
        topGoal.backgroundColor = .clearColor()
        bottomGoal.frame = CGRect(x: 0, y: screen.height - 50, width: cornerWidth * 4, height: 50)
        bottomGoal.backgroundColor = .clearColor()
        
        view.addSubview(topGoal)
        view.addSubview(bottomGoal)
        view.addSubview(bottomView)
        view.addSubview(topView)
        
        top.backgroundColor = .whiteColor()
        bottom.backgroundColor = .whiteColor()
        topLCorner.backgroundColor = .blackColor()
        topRCorner.backgroundColor = .blackColor()
        bottomRCorner.backgroundColor = .blackColor()
        bottomLCorner.backgroundColor = .blackColor()
        
        kick.frame = CGRect(x: screen.width - 75, y: screen.height - 75, width: 50, height: 50)
        kick.setImage(UIImage(named: "grayButton.png"), forState: .Normal)
        
        secondKickButton.frame = CGRect(x: 50, y: 50, width: 50, height: 50)
        secondKickButton.setImage(UIImage(named: "grayButton.png"), forState: .Normal)
        
        view.addSubview(top)
        view.addSubview(ballView)
        view.addSubview(firstPlayer)
        view.addSubview(topRCorner)
        view.addSubview(topLCorner)
        view.addSubview(kick)
        view.addSubview(secondKickButton)
        view.addSubview(bottomLCorner)
        view.addSubview(bottomRCorner)
        view.addSubview(bottom)
        
        
        if self.mode == "ai"{
            view.addSubview(aiBall)
        }
        else if self.mode == "twoPlayers"{
            view.addSubview(secondPlayer)
        }
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
        let ball = view.viewWithTag(333)!
        let player = view.viewWithTag(222)!
        
        let dist = distanceBetween(ball.center, pointTwo: player.center)
        
        if dist <= 70 {
            let postCollisionDirection = UIDynamicItemBehavior(items: [ballView])
            postCollisionDirection.addLinearVelocity(CGPoint(x: 6*(ballView.center.x - firstPlayer.center.x), y: 6*(ballView.center.y - firstPlayer.center.y)), forItem: ballView)
            animator?.addBehavior(postCollisionDirection)
            
        }
        
    }
    
    func playerTwoKickBall(){
        
        let ball = view.viewWithTag(333)!
        let player = view.viewWithTag(777)!
        
        let dist = distanceBetween(ball.center, pointTwo: player.center)
        
        if dist <= 70 {
            let postCollisionDirection = UIDynamicItemBehavior(items: [ballView])
            postCollisionDirection.addLinearVelocity(CGPoint(x: 6*(ballView.center.x - secondPlayer.center.x), y: 6*(ballView.center.y - secondPlayer.center.y)), forItem: ballView)
            animator?.addBehavior(postCollisionDirection)
            
        }
        
    
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        totalCoin = Coins.fetchCoins("coinNumber").valueForKey("coinNumber")
        
        pause.frame = CGRect(x: topRCorner.center.x, y: topRCorner.center.y, width: 75, height: 50)
        
        pause.setTitle("Pause", forState: .Normal)
        
        pause.setTitleColor(.redColor(), forState: .Normal)
        
        
        topRCorner.addSubview(pause)
        topRCorner.bringSubviewToFront(pause)
        
        let triangleViewTR = UIView()
        triangleViewTR.frame = CGRect(x: screen.width / 2, y: screen.height / 2, width: 50, height: 50)
        triangleViewTR.backgroundColor = .blackColor()
        triangleViewTR.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        triangleViewTR.center = CGPoint(x: screen.width, y: 50)
        view.addSubview(triangleViewTR)
        
        let triangleViewTL = UIView()
        triangleViewTL.frame = CGRect(x: screen.width / 2, y: screen.height / 2, width: 50, height: 50)
        triangleViewTL.backgroundColor = .blackColor()
        triangleViewTL.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        triangleViewTL.center = CGPoint(x: 0, y: 50)
        view.addSubview(triangleViewTL)
        
        let triangleViewBR = UIView()
        triangleViewBR.frame = CGRect(x: screen.width / 2, y: screen.height / 2, width: 50, height: 50)
        triangleViewBR.backgroundColor = .blackColor()
        triangleViewBR.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        triangleViewBR.center = CGPoint(x: screen.width, y: screen.height - 50)
        view.addSubview(triangleViewBR)
        
        let triangleViewBL = UIView()
        triangleViewBL.frame = CGRect(x: screen.width / 2, y: screen.height / 2, width: 50, height: 50)
        triangleViewBL.backgroundColor = .blackColor()
        triangleViewBL.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        triangleViewBL.center = CGPoint(x: 0, y: screen.height - 50)
        view.addSubview(triangleViewBL)
        
        self.navigationController?.navigationBarHidden = true
        
//         #selector(ViewController.startGame)
        start.addTarget(self, action: #selector(ViewController.startGame), forControlEvents: .TouchDown)
        
//        #selector(ViewController.kickBall)
        kick.addTarget(self, action: #selector(ViewController.kickBall), forControlEvents: .TouchDown)
        
        //#selector(ViewController.pauseGame)
        pause.addTarget(self, action: #selector(ViewController.pauseGame), forControlEvents: .TouchDown)
        
        secondKickButton.addTarget(self, action: #selector(ViewController.playerTwoKickBall), forControlEvents: .TouchDown)
        
        animator = UIDynamicAnimator(referenceView: view)

        addViews()
        if self.mode == "ai"{
            startTimer()
            secondKickButton.enabled = false
            secondKickButton.hidden = true
        }
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
        view.bringSubviewToFront(kick)
        
        if self.mode == "ai"{
            aiBehavior = UIDynamicItemBehavior(items: [aiBall])
            aiBehavior.allowsRotation = false
            aiBehavior.elasticity = 0.40
            aiBehavior.friction = 0.00
            aiBehavior.density = 0.25
            aiBehavior.resistance = 5.0
            
            animator?.addBehavior(aiBehavior)
        }
        else{
            secondBehavior = UIDynamicItemBehavior(items: [secondPlayer])
            secondBehavior.allowsRotation = false
            secondBehavior.elasticity = 0.40
            secondBehavior.friction = 0.00
            secondBehavior.density = 0.5
            secondBehavior.resistance = 5.0
            secondBehavior.density = 0.5
            
            animator?.addBehavior(secondBehavior)
        }
        
        let cornerBehavior = UIDynamicItemBehavior(items: [triangleViewTL, triangleViewTR, triangleViewBL, triangleViewBR])
        cornerBehavior.anchored = true
        animator?.addBehavior(cornerBehavior)
        
        ballBehavior = UIDynamicItemBehavior(items: [ballView])
        ballBehavior.allowsRotation = false
        ballBehavior.elasticity = 0.40
        ballBehavior.friction = 0.00
        ballBehavior.resistance = 0.0
        ballBehavior.density = 0.05
        animator?.addBehavior(ballBehavior)
        
        playerBehavior = UIDynamicItemBehavior(items: [firstPlayer])
        playerBehavior.allowsRotation = false
        playerBehavior.elasticity = 0.40
        playerBehavior.friction = 0.0
        playerBehavior.resistance = 5.0
        playerBehavior.density = 0.5
        animator?.addBehavior(playerBehavior)
        
        boundBehavior = UIDynamicItemBehavior(items: [topRCorner, topLCorner, bottomRCorner, bottomLCorner, bottom, top, bottomGoal, topGoal])
        boundBehavior.allowsRotation = false
        boundBehavior.elasticity = 0.0
        boundBehavior.anchored = true
        animator?.addBehavior(boundBehavior)
        
        collision = UICollisionBehavior(items: [ballView, firstPlayer, topLCorner, topRCorner, bottomLCorner, bottomRCorner, bottom, top, triangleViewTL, triangleViewTR, triangleViewBL, triangleViewBR])
        collision.collisionMode = UICollisionBehaviorMode.Everything
        collision.translatesReferenceBoundsIntoBoundary = true
        
        if self.mode == "ai"{
            collision.addItem(aiBall)
        }
        else{
            collision.addItem(secondPlayer)
        }
        
        animator.addBehavior(collision)
        
        goalCollision = UICollisionBehavior(items: [firstPlayer, bottomGoal, topGoal])
        goalCollision.collisionMode = UICollisionBehaviorMode.Everything
        goalCollision.translatesReferenceBoundsIntoBoundary = true
        if self.mode == "ai"{
            goalCollision.addItem(aiBall)
        }
        else{
            goalCollision.addItem(secondPlayer)
        }
        animator.addBehavior(goalCollision)
        
        // idea- make a seperate collision for two views and the balls so players cant go in goal
        goalCollision.collisionDelegate = self
        collision.collisionDelegate = self

        beginGame()
        
    }
    
    
    func pauseGame(){
        
        if pauseIndex == 0{
            
            ballBehavior.resistance = 10000000
            playerBehavior.resistance = 100000000
            secondBehavior.resistance = 1000000000
            aiBehavior.resistance = 1000000000
            
            animator.updateItemUsingCurrentState(ballView)
            animator.updateItemUsingCurrentState(firstPlayer)
            animator.updateItemUsingCurrentState(aiBall)
            animator.updateItemUsingCurrentState(secondPlayer)
        
            
            view.addSubview(pause)
            view.bringSubviewToFront(pause)
            
            pause.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
            pause.setTitle("Resume", forState: .Normal)
            pause.setTitleColor(.greenColor(), forState: .Normal)

            
            
        self.navigationController?.navigationBarHidden = false
        
            pauseIndex = 1
        } else {
            self.navigationController?.navigationBarHidden = true
            
            pauseIndex = 0
            
            pause.center = CGPoint(x: topRCorner.center.x ,y: topRCorner.center.y)
            pause.setTitle("Pause", forState: .Normal)
            pause.setTitleColor(.redColor(), forState: .Normal)
            
            ballBehavior.resistance = 0.0
            playerBehavior.resistance = 5.0
            secondBehavior.resistance = 5.0
            aiBehavior.resistance = 0.0
            
            animator.updateItemUsingCurrentState(ballView)
            animator.updateItemUsingCurrentState(firstPlayer)
            animator.updateItemUsingCurrentState(aiBall)
            animator.updateItemUsingCurrentState(secondPlayer)
            

        }
    }
    
    func startGame() {
        
        ballView.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        secondPlayer.frame = CGRect(x: screen.width / 2, y: screen.height / 5, width: 50, height: 50)
        
        start.hidden = true
        
        ballBehavior.density = 0.1
        
        ballBehavior.resistance = 0.0
        
        playerBehavior.resistance = 5.0
        
        secondBehavior.resistance = 5.0
        
        aiBehavior.resistance = 5.0
        
        animator.updateItemUsingCurrentState(ballView)
        animator.updateItemUsingCurrentState(firstPlayer)
        animator.updateItemUsingCurrentState(secondPlayer)
        animator.updateItemUsingCurrentState(aiBall)
        

        
    }
    
    func beginGame(){
        
        
        start.setTitle("Start", forState: .Normal)
        
        start.setTitleColor(.redColor(), forState: .Normal)
        
        start.frame = CGRect(x: screen.width / 2, y: screen.width / 2, width: 50, height: 50)
        
        view.addSubview(start)
        
        start.hidden = false
        
        ballView.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        secondPlayer.frame = CGRect(x: screen.width / 2, y: screen.height / 5, width: 50, height: 50)
        
        ballBehavior.resistance = 10000000
        
        secondBehavior.resistance = 1000000
        
        firstPlayer.center = CGPoint(x: screen.width / 2, y: ballView.center.y + 250)
        
        //idea - have the distance between the ball and two players be a static number
        
        playerBehavior.resistance = 100000000
        
        aiBehavior.resistance = 10000000
        
        aiBall.center = CGPoint(x: screen.width / 2, y: ballView.center.y - 250)
        
        animator.updateItemUsingCurrentState(ballView)
        animator.updateItemUsingCurrentState(firstPlayer)
        animator.updateItemUsingCurrentState(secondPlayer)
        animator.updateItemUsingCurrentState(aiBall)
        
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onTick", userInfo: nil, repeats: true)

        
        //#selector(ViewController.onTick
    }
    
    
    
    func onTick(){
        if self.mode == "ai"{
            let playerPush = UIPushBehavior(items: [firstPlayer], mode: .Instantaneous)
            if topView.vector != .zero{
                playerPush.pushDirection = topView.vector
            }
            else{
                playerPush.pushDirection = bottomView.vector
            }
            playerPush.active = true
            animator?.addBehavior(playerPush)

            xdiff = Int(arc4random_uniform(151)) - 75
            ydiff = Int(arc4random_uniform(151)) - 75
            
            let newX = Int(ballView.center.x) + xdiff
            let newY = Int(ballView.center.y) + ydiff
            
            let velX = newX - Int(aiBall.center.x)
            let velY = newY - Int(aiBall.center.y)
            let aiMovement = UIDynamicItemBehavior(items: [aiBall])

            
            if index == 0{
                aiMovement.addLinearVelocity(CGPoint(x: velX, y: velY), forItem: aiBall)
                animator?.addBehavior(aiMovement)
            }
            else{
                aiMovement.addLinearVelocity(CGPoint(x: velX, y: velY), forItem: aiBall)
                animator.updateItemUsingCurrentState(aiBall)
            }
        }
        else{
            let topPush = UIPushBehavior(items: [secondPlayer], mode: .Instantaneous)
            topPush.pushDirection = topView.vector
            topPush.active = true
            self.animator?.addBehavior(topPush)
            
            let bottomPush = UIPushBehavior(items: [firstPlayer], mode: .Instantaneous)
            bottomPush.pushDirection = bottomView.vector
            bottomPush.active = true
            self.animator?.addBehavior(bottomPush)
        }
    }
    
    func scored(){
        
        start.setTitle("Start", forState: .Normal)
        
        start.setTitleColor(.redColor(), forState: .Normal)
        
        start.frame = CGRect(x: screen.width / 2, y: screen.width / 2, width: 50, height: 50)
        
        view.addSubview(start)
        
        start.hidden = false
        
        ballView.center = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        secondPlayer.frame = CGRect(x: screen.width / 2, y: screen.height / 5, width: 50, height: 50)

        secondBehavior.resistance = 10000000
        
        ballBehavior.resistance = 10000000
        
//        pushBehavior.active = false
        
        firstPlayer.center = CGPoint(x: screen.width / 2, y: ballView.center.y + 250)
        
        playerBehavior.resistance = 10000000
        
        aiBall.center = CGPoint(x: screen.width / 2, y: ballView.center.y - 250)
        
        aiBehavior.resistance = 10000000
        
        animator.updateItemUsingCurrentState(ballView)
        animator.updateItemUsingCurrentState(firstPlayer)
        animator.updateItemUsingCurrentState(secondPlayer)
        animator.updateItemUsingCurrentState(aiBall)
        
}
    
    func endGame(winner : String){
        
        let alert = UIAlertController(title: "\(winner) Won!", message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok!", style: .Cancel, handler: { (UIAlertAction) -> Void in
            ""
        }))
        
        
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint)
    {
        let first = item1 as! UIView
        let second = item2 as! UIView
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        if first == ballView && second == top{
            scored()
            scoreOne += 1
            player1Label.text = "Score: \(scoreOne)"
            
            fetchCoin()
            
            if checkFetchArray.count == 0{
                Coins.addCoins(1)
                print("added players coins")
            }else{
                batchUpdate()
            }
            
            if scoreOne == scoreLimit {
                // end game
            }
            
        }
        if first == ballView && second == bottom{
            scored()
            scoreTwo += 1
            player2Label.text = "Score: \(scoreTwo)"
            
            if scoreTwo == scoreLimit{
                //end game
            }
        }
        
        if first.isEqual(aiBall) && second.isEqual(ballView){
            
            
            let xCreate = Int(ballView.center.x) + xdiff
            let yCreate = Int(ballView.center.x) + ydiff
            
            let xAI = Int(aiBall.center.x)
            let yAI = Int(aiBall.center.y)
            
            
            let slopey = (yCreate - yAI)
            let slopex = (xCreate - xAI)
            
            var numb = Int(arc4random_uniform(5))
            
            let thirds = screen.height / 3
            
            if aiBall.center.y <= thirds{
                // defense
                if numb <= Dnumber{
                    
                    let aiKick = UIDynamicItemBehavior(items: [ballView])
                    aiKick.addLinearVelocity(CGPoint(x: slopex,y: slopey), forItem: ballView)
                    animator?.addBehavior(aiKick)
                }
            }
            if aiBall.center.y <= thirds * 2 && aiBall.center.y > thirds{
                //midfield
                if numb <= Mnumber{
                    
                    let aiMidKick = UIDynamicItemBehavior(items: [ballView])
                    aiMidKick.addLinearVelocity(CGPoint(x: slopex,y: slopey), forItem: ballView)
                    animator?.addBehavior(aiMidKick)
                }
            }
            if aiBall.center.y > thirds * 2{
                // offense
                if numb <= Onumber{
                    
                    let aiOffKick = UIDynamicItemBehavior(items: [ballView])
                    aiOffKick.addLinearVelocity(CGPoint(x: slopex,y: slopey), forItem: ballView)
                    animator?.addBehavior(aiOffKick)
                }
            }
        }
    }

    
    func fetchCoin(){
        
        
        let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Coins")
        
        if let fetchResults = (try? managedContext.executeFetchRequest(fetchRequest)) as? [Coins] {
            data = fetchResults
        }
        
        if data.count > 0 {
            
            for result in data as [NSManagedObject] {
                
                totalCoin = String(result.valueForKey("coinNumber")!)
                
                checkFetchArray.append(String(result.valueForKey("coinNumber")!))
            }
        }
        else {
        }
        
    }
    
    func batchUpdate(){
        
        let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let batchRequest = NSBatchUpdateRequest(entityName: "Coins")
        //need to add to the fetch not update like this cause it resets.
        batchRequest.propertiesToUpdate = [ "coinNumber" : "\(Int(totalCoin)! + 1)" ]
        batchRequest.resultType = .UpdatedObjectIDsResultType
        
        do {
            let objectIDs = try moc.executeRequest(batchRequest) as! NSBatchUpdateResult
            let objects = objectIDs.result as! [NSManagedObjectID]
            
            objects.forEach({objID in
            
                let managedObject = moc.objectWithID(objID)
                moc.refreshObject(managedObject, mergeChanges: false)
            
            })
            
        }
        catch{
            
        }
        
        
    }
    
    
}



