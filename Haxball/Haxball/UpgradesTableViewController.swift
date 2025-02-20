//
//  UpgradesTableViewController.swift
//  Haxball
//
//  Created by apcsp on 11/21/16.
//  Copyright © 2016 potragatetz. All rights reserved.
//

import UIKit
import CoreData

class UpgradesTableViewController: UITableViewController {

    var cells : [Upgrade] = []
    
    var checkFetch : [String] = []
    
    override func viewDidLoad() {
        UpgradesCD.fetchUpgrades("speed")
        self.title = "Coins: \(ViewController.fetchCoin())"
        super.viewDidLoad()
        
        //have images with the real names and have the name name underneath just to pull from core data
        
        cells.append(Upgrade(name: "speed", cost: 5, image: UIImage(named: "Clear")!))
        cells.append(Upgrade(name: "power", cost: 5, image: UIImage(named: "Clear")!))
        cells.append(Upgrade(name: "ballColor", cost: 5, image: UIImage(named: "Clear")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func upgrade(_ sender: AnyObject) {
        self.title = "Coins: \(ViewController.fetchCoin())"
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cells.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upgradeCell", for: indexPath) as! UpgradeTableViewCell

        // Configure the cell...
        cell.nameLabel.text = cells[indexPath.row].name
        cell.tierLabel.text = String(cells[indexPath.row].tier)
        cell.tierLabel.text = fetchUpgrade("\(cells[indexPath.row].name)")
        cell.costLabel.text = String(cells[indexPath.row].cost)
        cell.leImageView.image = cells[indexPath.row].image
        return cell
    }
    
    
    var data = [NSManagedObject]()
    var itemz : String = String()
    
    func fetchUpgrade(_ item: String) -> String{
        let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        let fetchREquest = NSFetchRequest<NSFetchRequestResult>(entityName: "UpgradesCD")
        
        if let fetchREsult = (try? moc.fetch(fetchREquest)) as? [UpgradesCD] {
            data = fetchREsult
        }
        
        
        if data.count > 0{
                for result in data as [NSManagedObject] {
                    
                    itemz = String(describing: result.value(forKey: item)!)
                    
                
            }
        }
        return itemz
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
