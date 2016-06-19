//
//  View.swift
//  FakeSquare
//
//  Created by Azzaro Mujic on 19/06/16.
//  Copyright © 2016 Azzaro Mujic. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set(borderWidth) {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(CGColor: layer.borderColor ?? UIColor.clearColor().CGColor)
        }
        
        set(borderColor) {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set(cornerRadius) {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
}