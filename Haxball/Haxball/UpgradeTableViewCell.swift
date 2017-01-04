
//
//  SpeedTableViewCell.swift
//  Haxball
//
//  Created by apcsp on 11/21/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class UpgradeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var leImageView: UIImageView!
    

    
    @IBAction func realUpgrade(_ sender: AnyObject) {
        let currentTier = Int(tierLabel.text!)
        
        if self.nameLabel.text! == "speed"{
            
            
            let coin = ViewController.fetchCoin()
            
            if coin >= Int(costLabel.text!){
                
                ViewController.batchUpdate(coin - Int(self.costLabel.text!)!)
                
                ViewController.universalBatchUpdate("UpgradesCD", newValue: currentTier! + 1, upgradeName: "speed")
                
                print("\(ViewController.fetchCoin())")
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
}
