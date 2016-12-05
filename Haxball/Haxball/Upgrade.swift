//
//  Upgrade.swift
//  Haxball
//
//  Created by apcsp on 12/5/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit

class Upgrade: NSObject {
    var name : String = ""
    var cost : Int = 0
    var tier : Int = 0
    
    init(name : String, cost : Int) {
        self.name = name
        self.cost = cost
        self.tier = 1
    }
}
