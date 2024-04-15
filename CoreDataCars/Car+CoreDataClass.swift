//
//  Car+CoreDataClass.swift
//  CoreDataCars
//
//  Created by Дмитрий Яновский on 8.04.24.
//
//

import Foundation
import CoreData

@objc(Car)
public class Car: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "Car"), insertInto: CoreDataManager.shared.context)
    }

}
