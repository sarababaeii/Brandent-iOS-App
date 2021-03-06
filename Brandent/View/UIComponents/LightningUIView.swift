//
//  LightningView.swift
//  Brandent
//
//  Created by Sara Babaei on 11/5/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class LightningUIView: CustomUIView {
    
    @IBInspectable var lightGradientColor: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var darkGradientColor: UIColor = UIColor.white {
        didSet{
            self.setGradient()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
        didSet {
            updateGradientDirection()
        }
    }
    
    private func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.colors = [lightGradientColor.cgColor, darkGradientColor.cgColor]
        
        removeGradient()
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeGradient() {
        if let gradientLayer = self.getGradientLayer() {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    private func getGradientLayer() -> CALayer? {
        if let topLayer = self.layer.sublayers?.first, topLayer is CAGradientLayer {
            return topLayer
        }
        return nil
    }
    
    func updateGradientDirection() {
        if isHorizontal, let gradient = getGradientLayer() as? CAGradientLayer {
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        }
    }
    
    func resizeGradientLayer() {
        if let gradientLayer = self.getGradientLayer() {
            gradientLayer.frame = self.bounds
        }
    }
}
