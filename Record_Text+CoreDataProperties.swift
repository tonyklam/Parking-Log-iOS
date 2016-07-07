//
//  Record_Text+CoreDataProperties.swift
//  ParkingLog
//
//  Created by Tony Lam on 26/05/2016.
//  Copyright © 2016 Tony Lam. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Record_Text {

    @NSManaged var floor: String?
    @NSManaged var space: String?
    @NSManaged var area: String?
    @NSManaged var direction: String?
    @NSManaged var time: NSDate?

}
