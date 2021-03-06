//
//  TextViewDelegate.swift
//  Brandent
//
//  Created by Sara Babaei on 10/16/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class TextViewDelegate: NSObject, UITextViewDelegate {
    let maxLength = 250
    
    var characterLimitLabel: UILabel
    
    //MARK: Initializer
    init(label: UILabel) {
        characterLimitLabel = label
    }
    
    //MARK: Placeholder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Color.gray.componentColor {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPlaceHolder(textView: textView, text: "اطلاعات تکمیلی")
        }
    }
    
    func setPlaceHolder(textView: UITextView, text: String) {
        textView.text = text
        textView.textColor = Color.gray.componentColor
    }
    
    //MARK: Character Limit
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars <= maxLength
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.fetchInput() else {
            return
        }
        let remain = calculateRemainigCharacters(string: text)
        if remain <= 20 {
            setWordLimit(amount: remain)
        } else {
            characterLimitLabel.isHidden = true
        }
    }
    
    func calculateRemainigCharacters(string: String) -> Int {
        return maxLength - string.count
    }
    
    func setWordLimit(amount: Int) {
        let amountString = String(amount).convertEnglishNumToPersianNum()
        characterLimitLabel.text = "+\(amountString)"
        characterLimitLabel.isHidden = false
    }
}
