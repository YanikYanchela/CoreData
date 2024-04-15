//
//  Car+CoreDataProperties.swift
//  CoreDataCars
//
//  Created by Дмитрий Яновский on 8.04.24.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var brand: String?
    @NSManaged public var model: String?
    @NSManaged public var year: Int16
    @NSManaged public var engine: Double

}

extension Car : Identifiable {

}
