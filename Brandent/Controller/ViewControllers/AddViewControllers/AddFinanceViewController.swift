//
//  AddFinanceViewController.swift
//  Brandent
//
//  Created by Sara Babaei on 11/3/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit
import SwiftyMenu

class AddFinanceViewConrtoller: FormViewController, SwiftyMenuDelegate {
    
    @IBOutlet weak var titleTextField: CustomTextField!
    @IBOutlet weak var priceTextField: CustomTextField!
    @IBOutlet weak var kindMenu: SwiftyMenu!
    @IBOutlet weak var dateTextField: CustomTextField!
    
    var textFieldDelegates = [TextFieldDelegate]()
    let kindOptions = ["درآمد", "هزینه"]
    
    var isCost: Bool?
    
    var finance: Finance?
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        initializeTextFields()
        setKindMenuDelegates()
        setDatePicker(dateTextFieldIndex: 2, mode: .date)
        setTitle(title: "افزودن تراکنش")
    }
    
    func initializeTextFields() {
        textFields = [titleTextField, priceTextField, dateTextField]
        data = ["", -1] as [Any] //0: title, 1: price
        setTextFieldDelegates()
        setTextFieldsData()
    }
    
    func setTextFieldsData() {
        if let finance = finance {
            titleTextField.text = finance.title
            priceTextField.text = String.toPersianPriceString(price: Int(truncating: finance.amount))
//            kindMenu
//            dateTextField
            data = [finance.title, finance.amount]
            isCost = finance.is_cost
//            date
        }
    }
    
    func setTextFieldDelegates() {
        textFieldDelegates = [
            TextFieldDelegate(viewController: self, isForPrice: false, isForDate: false),
            TextFieldDelegate(viewController: self, isForPrice: true, isForDate: false),
            TextFieldDelegate(viewController: self, isForPrice: false, isForDate: true)]
        for i in 0 ..< 3 {
            textFields[i].delegate = textFieldDelegates[i]
        }
    }
    
    //MARK: DropDownMenu Functions
    func setKindMenuDelegates() {
        kindMenu.delegate = self
        kindMenu.options = kindOptions
        kindMenu.collapsingAnimationStyle = .spring(level: .low)
    }
    
    func didSelectOption(_ swiftyMenu: SwiftyMenu, _ selectedOption: SwiftMenuDisplayable, _ index: Int) {
        switch index {
        case 0:
            isCost = false
        case 1:
            isCost = true
        default:
            isCost = nil
        }
    }
    
    //MARK: User Flow
    @IBAction func hideKeyboard(_ sender: Any) {
        if let textField = currentTextField {
            textField.resignFirstResponder()
        }
    }
    
    //MARK: Submission
    @IBAction func submit(_ sender: Any) {
        submitForm()
    }
    
    override func mustComplete() -> Any? {
        if data[0] as! String == "" {
            return textFields[0]
        }
        if data[1] as! Int == -1 {
            return textFields[1]
        }
        if isCost == nil {
            return kindMenu
        }
        if date == nil {
            return textFields[2]
        }
        return nil
    }
    
    override func saveData() {
        let finance = Finance.getFinance(id: self.finance?.id, title: data[0] as! String, amount: data[1] as! Int, isCost: isCost!, date: date!)
        RestAPIManagr.sharedInstance.addFinance(finance: finance)
    }
}
