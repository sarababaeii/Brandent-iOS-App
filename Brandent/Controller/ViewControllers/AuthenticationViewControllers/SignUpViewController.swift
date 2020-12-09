//
//  SignUpViewController.swift
//  Brandent
//
//  Created by Sara Babaei on 12/9/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    
    var phoneNumber = ""
    
    //MARK: User Flow
    @IBAction func editingEnded(_ sender: Any) {
        if let textField = sender as? UITextField, let text = textField.fetchInput() {
            phoneNumber = text
        }
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        if let textField = sender as? UITextField {
            textField.resignFirstResponder()
        }
    }
    
    //Mark: Submission
    func mustComplete() -> CustomTextField? {
        print(phoneNumber)
        if phoneNumber == "" {
            return phoneNumberTextField
        }
        return nil
    }
        
    func submitionError(for textField: CustomTextField) {
        textField.showError()
        self.showToast(message: "خطا: همه‌ی موارد ضروری وارد نشده است.")
    }
    
    @IBAction func getCode(_ sender: Any) {
        editingEnded(phoneNumberTextField as Any)

        if let requiredTextField = mustComplete() {
            submitionError(for: requiredTextField)
            return
        }

        print(phoneNumber)
    }
    
    //MARK: Initialization
    func setPhoneNumber() {
        if phoneNumber != "" {
            phoneNumberTextField.text = phoneNumber
        }
    }
    
    func configure() {
        setPhoneNumber()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
    }
}

//TODO: go to next page programmatically