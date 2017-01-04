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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(scoreLimit[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedScore = scoreLimit[row]
        
    }
    func makeBarButton(){
    
        let button : UIButton = UIButton()
        button.setTitle("Coins: \(ViewController.fetchCoin())", for: UIControlState())
        button.setTitleColor(.black, for: UIControlState())
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let leftBarItem : UIBarButtonItem = UIBarButtonItem()
        leftBarItem.customView = button
        let negativeSpaver : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)

        negativeSpaver.width = -5
        self.navigationItem.leftBarButtonItems = [negativeSpaver, leftBarItem]
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        makeBarButton()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        makeBarButton()

        scorePicker.delegate = self
        scorePicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destination as? ViewController
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
