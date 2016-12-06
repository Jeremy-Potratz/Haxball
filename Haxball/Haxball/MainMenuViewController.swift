//
//  MainMenuViewController.swift
//  Haxball
//
//  Created by Scott on 11/16/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var difficultySelector: UISegmentedControl!
    
    @IBOutlet weak var scorePicker: UIPickerView!
    
    var pickerView : UIPickerView!
    
    var scoreLimit = [1,2,3,4,5,6,7,8,9,10]
    
    var selectedScore = 1
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(scoreLimit[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedScore = scoreLimit[row]
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scorePicker.delegate = self
        scorePicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destinationViewController as? ViewController
        if segue.identifier == "startGame"{
            //Set gamemode
            dest?.scoreLimit = selectedScore
            
            if difficultySelector.selectedSegmentIndex == 0{
                dest!.mode = "ai"
            }
            else if difficultySelector.selectedSegmentIndex == 1{
                dest!.mode = "twoPlayers"
            }
        }
    }
 

}
