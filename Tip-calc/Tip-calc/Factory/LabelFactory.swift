//
//  LabelFactory.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 12.05.2024.
//

import UIKit

struct LabelFactory {
    static func build(text: String, 
                      font: UIFont,
                      backgraoundColor: UIColor = .clear,
                      textColor: UIColor = ThemeColor.textColor,
                      textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgraoundColor
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
