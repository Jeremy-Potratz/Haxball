//
//  offense.swift
//  Haxball
//
//  Created by Jeremy Otto Potratz on 11/14/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import Foundation
import UIKit

class offense{
    
    var balls = ViewController.ai.aiBall
    var theBall = ViewController.ai.bals
    var timer : NSTimer? = nil
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onTick", userInfo: nil, repeats: false)
    }
    
    func ai(){
        // i could add linear velocity to the ball by calculating slope between ai ball and the point near the ball i create
        
        let xdiff = Int(arc4random_uniform(75))
        let ydiff = Int(arc4random_uniform(75))
        // will always try and stay within a view and a half
        
        
        let xCreate = Int(theBall.center.x) + xdiff
        let yCreate = Int(theBall.center.x) + ydiff
        
        let xAI = Int(balls.center.x)
        let yAI = Int(balls.center.y)
        
        
        let slope = (yCreate - yAI)/(xCreate - xAI)
        
        
        print(slope)
        
        
        
        while Int(xdiff) < Int(theBall.center.x){
            
            balls.center.x = balls.center.x + 1
            
            
        }
        
        while Int(xdiff) < Int(theBall.center.x) && Int(ydiff) < Int(theBall.center.y){
            
            
        }
        
        // have three whiles. one that evaluates if both x and y are more, one for just x and one for just y, then three more for if its less
        // another one evaluating if more than that, definitaly more kicking at defense
        
    }
    
    func onTick(){
//        timer:NSTimer 
        //Runs 10 times a second
        print("hello")
        
        
        
        balls.center.x = theBall.center.x
        
    }
    
    // function so if the ball is past the ai the ai goes right back to in front of goal
}