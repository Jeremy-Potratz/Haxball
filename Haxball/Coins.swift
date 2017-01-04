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
    
    class func addCoins(_ coins: Int){
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        let newCoins = NSEntityDescription.insertNewObject(forEntityName: String(describing: Coins.self), into: moc) as! Coins
        
        
        newCoins.coinNumber = coins as NSNumber?
        
        do {
            try moc.save()
        }catch{
            // error
            print("error")
        }
        
    }
    
    class func fetchCoins(_ sortDescriptorre: String) -> [NSManagedObject]{
        
        
            var data = [NSManagedObject]()
            
            //NSFETCH SHIz
            
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Coins")
            
            let sortDescriptor = NSSortDescriptor(key: "\(sortDescriptorre)", ascending: true)
            
            fetchRequest.sortDescriptors = [sortDescriptor]

            
            if let fetchResults = (try? managedContext.fetch(fetchRequest)) as? [Coins] {
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
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Coins.self))
        
        var stats = [Coins]()
        
        do {
            stats = try moc.fetch(fetchRequest) as! [Coins]
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
