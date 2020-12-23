//
//  Appointment+CoreDataClass.swift
//  Brandent
//
//  Created by Sara Babaei on 9/30/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Appointment)
public class Appointment: NSManagedObject {
    
    static func createAppointment(id: UUID, patientID: UUID, clinicID: UUID, diseaseTitle: String, price: Int, date: Date) -> Appointment {
        if let appointment = getAppointmentByID(id) { // for sync
            return appointment
        }
        let clinic = Clinic.getClinicByID(clinicID)!
        let patient = Patient.getPatientByID(patientID)! //TODO: sare unwrapping
        return createAppointment(id: id, patient: patient, clinic: clinic, diseaseTitle: diseaseTitle, price: price, date: date)
    }
    
    static func createAppointment(id: UUID?, patient: Patient, clinic: Clinic, diseaseTitle: String, price: Int, date: Date) -> Appointment {
        if let id = id, let appointment = getAppointmentByID(id) { // for add
            return appointment
        }
        let disease = Disease.getDisease(id: nil, title: diseaseTitle, price: price)
        return DataController.sharedInstance.createAppointment(id: id, patient: patient, disease: disease, price: price, visit_time: date, clinic: clinic)
    }
    
    static func getAppointmentByID(_ id: UUID) -> Appointment? {
        if let object = DataController.sharedInstance.fetchAppointment(id: id), let appointment = object as? Appointment {
            return appointment
        }
        return nil
    }
    
    func setAttributes(id: UUID?, patient: Patient, disease: Disease, price: Int, visit_time: Date, clinic: Clinic) {
        self.price = NSDecimalNumber(value: price)
        self.visit_time = visit_time
        self.state = State.todo.rawValue //should set
        self.clinic = clinic
        self.patient = patient
        self.disease = disease
      
        self.setID(id: id)
        self.setDentist()
        self.setModifiedTime()
    }
    
    func setState(tag: Int) {
        if tag == 1 {
            self.state = State.done.rawValue
        } else if tag == 0 {
            self.state = State.canceled.rawValue
        }
//        if self.visit_time > Date() {
//            self.state = State.todo.rawValue
//        } else {
//            self.state = State.done.rawValue
//        }
    } //yes?
    
    func setID(id: UUID?) {
        if let id = id {
            self.id = id
        } else {
            let uuid = UUID()
            self.id = uuid
        }
    }
    
    func setDentist() {
        if let dentist = Info.sharedInstance.dentist {
            self.dentist = dentist
        }
    }
    
    func setModifiedTime() {
        self.modified_at = Date()
    }
    
    //MARK: API Functions
    func toDictionary() -> [String: String] {
        let params = [
            APIKey.appointment.id!: self.id.uuidString,
            APIKey.appointment.price!: String(Int(truncating: self.price)),
            APIKey.appointment.state!: self.state,
            APIKey.appointment.date!: self.visit_time.toDBFormatDateAndTimeString(),
            APIKey.appointment.disease!: self.disease.title,
            APIKey.appointment.isDeleted!: String(self.isDeleted), //test
            APIKey.appointment.patient!: self.patient.id.uuidString,
            APIKey.appointment.clinic!: self.clinic.id.uuidString]
        return params
    }
    
    static func toDictionaryArray(appointments: [Appointment]) -> [[String: String]] {
        var params = [[String: String]]()
        for appointment in appointments {
            params.append(appointment.toDictionary())
        }
        return params
    }
    
    static func saveAppointment(_ appointment: NSDictionary) {
        guard let idString = appointment[APIKey.appointment.id!] as? String,
         let id = UUID.init(uuidString: idString),
         let patientIDString = appointment[APIKey.appointment.patient!] as? String,
         let patientID = UUID.init(uuidString: patientIDString),
         let disease = appointment[APIKey.appointment.disease!] as? String,
         let priceString = appointment[APIKey.appointment.price!] as? String,
         let price = Int(priceString),
         let dateString = appointment[APIKey.appointment.date!] as? String,
         let date = Date.getDBFormatDate(from: dateString),
         let clinicIDString = appointment[APIKey.appointment.clinic!] as? String,
         let clinicID = UUID.init(uuidString: clinicIDString) else {
            return
        }
        let _ = createAppointment(id: id, patientID: patientID, clinicID: clinicID, diseaseTitle: disease, price: price, date: date)
    }
}

//"appointment": {
//  "id": "890a32fe-12e6-11eb-adc1-0242ac120002",
//  "notes": "had a surgery last month",
//  "price": 5000000,
//  "state": "done",
//  "visit_time": "2020-10-20 17:05:30",
//  "disease": "checkup",
//  "is_deleted": false,
//  "clinic_id": "890a32fe-12e6-11eb-adc1-0242ac120002",
//  "allergies": "peanut butter",
//  "patient_id": "890a32fe-12e6-11eb-adc1-0242ac120002"
//}
