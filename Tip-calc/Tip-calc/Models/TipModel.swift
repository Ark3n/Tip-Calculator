//
//  Tip.swift
//  Tip-calc
//
//  Created by Arken Sarsenov on 12.05.2024.
//

import Foundation

enum TipModel {
    case none, tenPercent, fifteenPercent, twentyPercent
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return "\(value)"
        }
    }
}
