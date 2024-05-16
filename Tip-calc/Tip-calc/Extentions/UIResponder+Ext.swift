//
//  UIResponder+Ext.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 16.05.2024.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
