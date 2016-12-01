
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
    
//    init(name: String, cost : Int){
//        self.nameLabel.text = name
//        self.tierLabel.text = "0"
//        self.costLabel.text = String(cost)
//    }
    
}
