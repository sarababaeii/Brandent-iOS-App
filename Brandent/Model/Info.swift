//
//  Info.swift
//  Brandent
//
//  Created by Sara Babaei on 10/9/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation

class Info {
    static var sharedInstance = Info()
    
    @available(iOS 13.0, *)
    static var dataController = DataController()
}
