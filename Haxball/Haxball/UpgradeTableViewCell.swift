
//
//  SpeedTableViewCell.swift
//  Haxball
//
//  Created by apcsp on 11/21/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit

class UpgradeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var leImageView: UIImageView!
    

    
    @IBAction func realUpgrade(sender: AnyObject) {
        let currentTier = Int(tierLabel.text!)
        
        if self.nameLabel.text! == "Speed"{
            
            
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
}
