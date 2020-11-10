//
//  Disease+CoreDataClass.swift
//  Brandent
//
//  Created by Sara Babaei on 9/30/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Disease)
public class Disease: NSManagedObject {
    
    @available(iOS 13.0, *)
    static func getDisease(title: String, price: Int) -> Disease {
        if let disease = Info.dataController.fetchDisease(title: title) {
            return disease as! Disease
        }
        return Info.dataController.createDisease(title: title, price: price)
    }
    
    func setID() {
        let uuid = UUID()
        self.id = uuid
    }
    
    func setModifiedTime() {
        self.modified_at = Date()
    }
    
    func toDictionary() -> [String: String] {
        let params: [String: String] = [
            APIKey.disease.id!: self.id.uuidString,
            APIKey.disease.title!: self.title,
            APIKey.disease.price!: String(Int(truncating: self.price))
        ]
        return params
    }
    
    static func toDictionaryArray(diseases: [Disease]) -> [[String: String]] {
        var params = [[String: String]]()
        for disease in diseases {
            params.append(disease.toDictionary())
        }
        return params
    }
}

//"diseases": [
//  {
//    "id": "890a32fe-12e6-11eb-adc1-0242ac120002",
//    "title": "sine saratan",
//    "price": 50000000
//  }
//],
