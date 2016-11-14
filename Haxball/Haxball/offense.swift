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
        var xdiff = arc4random_uniform(50)
        var ydiff = arc4random_uniform(50)
        
        while Int(xdiff) < Int(theBall.center.x){
            
            balls.center.x = balls.center.x + 1
            
            
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
    
    
}