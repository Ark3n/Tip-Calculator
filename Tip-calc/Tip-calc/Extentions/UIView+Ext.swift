//
//  UIView+Ext.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 12.05.2024.
//

import UIKit

extension UIView {
    func addShadow(offSet: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offSet
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgraoundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgraoundCGColor
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.maskedCorners = [corners]
        layer.cornerRadius = radius
    }
}


