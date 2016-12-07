//
//  UpgradesCD+CoreDataProperties.swift
//  
//
//  Created by apcsp on 12/7/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UpgradesCD {

    @NSManaged var speed: NSNumber?
    @NSManaged var power: NSNumber?
    @NSManaged var ballColor: String?
    @NSManaged var backGround: String?
    @NSManaged var ballSize: NSNumber?
    @NSManaged var sandboxMode: NSNumber?

}
