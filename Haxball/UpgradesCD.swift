//
//  UpgradesCD.swift
//  
//
//  Created by apcsp on 12/7/16.
//
//

import Foundation
import CoreData
import UIKit


class UpgradesCD: NSManagedObject {

    class func addUpgrade(){
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        let upgraded = NSEntityDescription.insertNewObject(forEntityName: String(describing: UpgradesCD.self), into: moc) as! UpgradesCD
        
        
        upgraded.speed = 1
        upgraded.power = 1
        upgraded.ballColor = ""
        upgraded.backGround = ""
        upgraded.ballSize = 1
        upgraded.sandboxMode = 0
        
        do {
            try moc.save()
        }catch{
            // error
            print("error")
        }
        
    }
    
    class func fetchUpgrades(_ sortDescriptorre: String) -> [NSManagedObject]{
        
        
        var data = [NSManagedObject]()
        
        //NSFETCH SHIz
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UpgradesCD")
        
        let sortDescriptor = NSSortDescriptor(key: "\(sortDescriptorre)", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        if let fetchResults = (try? managedContext.fetch(fetchRequest)) as? [UpgradesCD] {
            data = fetchResults
        }
        
        if data.count > 0 {
            
            for result in data as [NSManagedObject] {
                
            }
        }
        else {
            print("No data")
            addUpgrade()
        }
        
        return data
        
    }
    
    class func nuke(){
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: UpgradesCD.self))
        
        var stats = [UpgradesCD]()
        
        do {
            stats = try moc.fetch(fetchRequest) as! [UpgradesCD]
        }catch{
            //error
            print("error")
        }
        
        for stat in stats{
            moc.delete(stat)
        }
        
        do{
            try moc.save()
            
        }catch {
            //error
        }
        
        
    }
}
