
//
//  SpeedTableViewCell.swift
//  Haxball
//
//  Created by apcsp on 11/21/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit

class UpgradeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var upgradeLabel: UILabel!
    @IBOutlet weak var tierLabel: UILabel!

    override init(name: String, cost: Int){
        //initialize
        self.costLabel.text = String(cost)
        self.tierLabel.text = "1"
        self.upgradeLabel.text = name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func upgrade(sender: AnyObject) {
    }
}
