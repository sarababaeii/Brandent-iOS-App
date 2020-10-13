//
//  CustomTextField.swift
//  Brandent
//
//  Created by Sara Babaei on 9/13/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomTextField: UITextField {
//    let sidePadding: CGFloat = 15
    
    @IBInspectable var sidePadding: CGFloat = 15 {
        didSet {
            
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor = UIColor(red: 202, green: 202, blue: 202, alpha: 1) {
        didSet {
            if let placeholder = self.placeholder {
                self.setPlaceHolderColor(string: placeholder, color: self.placeHolderColor)
            }
        }
    }
    
    func setPlaceHolderColor(string: String, color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: string, attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    @IBInspectable var iconImage: UIImage? {
        didSet {
            setLeftIcon()
        }
    }
    
    @IBInspectable var iconPadding: CGFloat = 0 {
        didSet {
            if let _ = iconImage {
                setLeftIcon()
            }
        }
    }
    
    func setLeftIcon() {
        guard let icon = iconImage else {
            return
        }
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: icon.size.width + iconPadding, height: icon.size.height) )
        let iconView  = UIImageView(frame: CGRect(x: 0, y: 0, width: icon.size.width, height: icon.size.height))
       
        iconView.image = icon
        outerView.addSubview(iconView)

        leftView = outerView
        leftViewMode = .always
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + sidePadding,
            y: bounds.origin.y,
            width: bounds.size.width - sidePadding * 2,
            height: bounds.size.height
        )
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
}

extension UITextField {
    func fetchInput() -> String? {
        if let caption = self.text?.trimmingCharacters(in: .whitespaces) {
            return caption.count > 0 ? caption : nil
        }
        return nil
    }
}
