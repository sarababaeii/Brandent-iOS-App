//
//  Clinic+CoreDataProperties.swift
//  Brandent
//
//  Created by Sara Babaei on 10/1/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//
//

import Foundation
import CoreData


extension Clinic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clinic> {
        return NSFetchRequest<Clinic>(entityName: "Clinic")
    }

    @NSManaged public var id: NSDecimalNumber?
    @NSManaged public var name: String?
    @NSManaged public var appointments: NSSet?
    @NSManaged public var dentist: Dentist?

}

// MARK: Generated accessors for appointments
extension Clinic {

    @objc(addAppointmentsObject:)
    @NSManaged public func addToAppointments(_ value: Appointment)

    @objc(removeAppointmentsObject:)
    @NSManaged public func removeFromAppointments(_ value: Appointment)

    @objc(addAppointments:)
    @NSManaged public func addToAppointments(_ values: NSSet)

    @objc(removeAppointments:)
    @NSManaged public func removeFromAppointments(_ values: NSSet)

}
