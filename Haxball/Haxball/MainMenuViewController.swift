//
//  MainMenuViewController.swift
//  Haxball
//
//  Created by Scott on 11/16/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var difficultySelector: UISegmentedControl!
    
    @IBOutlet weak var scorePicker: UIPickerView!
    
    var scoreLimit = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destinationViewController as! ViewController
        if segue.identifier == "startGame"{
            print("Seguing")
            //Set gamemode
            if difficultySelector.selectedSegmentIndex == 0{
                print("AIing")
                dest.mode = "ai"
            }
            else if difficultySelector.selectedSegmentIndex == 1{
                print("2ing")
                dest.mode = "twoPlayers"
                print("22ing")
            }
        }
    }
 

}
