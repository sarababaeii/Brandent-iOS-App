//
//  UIDatePickerExtension.swift
//  Brandent
//
//  Created by Sara Babaei on 11/4/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

extension UIDatePicker {
    func createPersianDatePicker() {
        self.calendar = Calendar(identifier: .persian)
        self.locale = Locale(identifier: "fa_IR")
        self.datePickerMode = .dateAndTime
//        datePicker.setValue(UIFont(name: "Vazir", size: 20), forKeyPath: "textFont")
    }
}
