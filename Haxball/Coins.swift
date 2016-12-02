//
//  Coins.swift
//  
//
//  Created by Jeremy Otto Potratz on 11/17/16.
//
//

import Foundation
import CoreData
import UIKit


class Coins: NSManagedObject {
    
    class func addCoins(coins: Int){
        
        let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let newCoins = NSEntityDescription.insertNewObjectForEntityForName(String(Coins), inManagedObjectContext: moc) as! Coins
        
        
        newCoins.coinNumber = coins
        
        do {
            try moc.save()
        }catch{
            // error
            print("error")
        }
        
    }
    
    class func fetchCoins(sortDescriptorre: String) -> [NSManagedObject]{
        
        
            var data = [NSManagedObject]()
            
            //NSFETCH SHIz
            
            let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            
            let fetchRequest = NSFetchRequest(entityName: "Coins")
            
            let sortDescriptor = NSSortDescriptor(key: "\(sortDescriptorre)", ascending: true)
            
            fetchRequest.sortDescriptors = [sortDescriptor]

            
            if let fetchResults = (try? managedContext.executeFetchRequest(fetchRequest)) as? [Coins] {
                data = fetchResults
            }
            
            if data.count > 0 {
                
                for result in data as [NSManagedObject] {
                                        
                }
            }
            else {
                print("No data")
            }
        
            return data
        
        }

    class func nuke(){
        
        let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: String(Coins))
        
        var stats = [Coins]()
        
        do {
            stats = try moc.executeFetchRequest(fetchRequest) as! [Coins]
        }catch{
            //error
            print("error")
        }
        
        for stat in stats{
            moc.deleteObject(stat)
        }
        
        do{
            try moc.save()
            
        }catch {
            //error
        }
        
        
    }
    
}
